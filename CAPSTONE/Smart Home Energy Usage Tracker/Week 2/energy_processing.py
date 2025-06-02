import pandas as pd
import numpy as np

#Load energy logs from CSV
df = pd.read_csv("D:\HEXAWARE PGET TRAINING\DATA ENGINEERING\Data-Warehouse-Training\CAPSTONE\Smart Home Energy Usage Tracker\Week 2\energy_usage.csv")

# Convert timestamp to datetime
df['timestamp'] = pd.to_datetime(df['timestamp'], errors='coerce')

# Ensure energy_kwh is float, invalid entries to NaN
df['energy_kwh'] = pd.to_numeric(df['energy_kwh'], errors='coerce')

# Drop invalid timestamps, device_id, or energy_kwh
df = df.dropna(subset=['timestamp', 'device_id', 'energy_kwh'])

# Remove negative or energy_kwh < 0
df = df[df['energy_kwh'] >= 0]

# Remove duplicates based on device_id and timestamp
df = df.drop_duplicates(subset=['device_id', 'timestamp'])

# Calculate total and average energy per device
device_energy = df.groupby('device_id')['energy_kwh'].agg(['sum', 'mean']).reset_index()
device_energy.columns = ['device_id', 'total_energy_kwh', 'avg_energy_kwh']
device_energy['total_energy_kwh'] = np.round(device_energy['total_energy_kwh'], 4)
device_energy['avg_energy_kwh'] = np.round(device_energy['avg_energy_kwh'], 4)

# Generate room-level summaries
room_summary = df.groupby('room_id')['energy_kwh'].agg(['sum', 'mean', 'count']).reset_index()
room_summary.columns = ['room_id', 'total_energy_kwh', 'avg_energy_kwh', 'reading_count']
room_summary['total_energy_kwh'] = np.round(room_summary['total_energy_kwh'], 4)
room_summary['avg_energy_kwh'] = np.round(room_summary['avg_energy_kwh'], 4)

# Save cleaned dataset
df.to_csv("cleaned_energy_usage.csv", index=False)

# Save summaries
device_energy.to_csv("device_energy_summary.csv", index=False)
room_summary.to_csv("room_energy_summary.csv", index=False)

# Print summaries
print("Device-Level Energy Summary:")
print(device_energy)
print("\nRoom-Level Energy Summary:")
print(room_summary)