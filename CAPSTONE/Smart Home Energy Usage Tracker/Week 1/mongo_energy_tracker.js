use EnergyDB;

// Insert sample sensor readings (JSON format)
db.SensorLogs.insertMany([
    {
        "device_id": 1,
        "timestamp": ISODate("2025-06-02T10:00:00Z"),
        "energy_kwh": 0.15,
        "voltage": 220,
        "current": 0.68
    },
    {
        "device_id": 1,
        "timestamp": ISODate("2025-06-02T10:01:00Z"),
        "energy_kwh": 0.14,
        "voltage": 221,
        "current": 0.65
    },
    {
        "device_id": 2,
        "timestamp": ISODate("2025-06-02T10:00:00Z"),
        "energy_kwh": 0.20,
        "voltage": 219,
        "current": 0.91
    }
]);

// Create indexes for quick lookup
db.SensorLogs.createIndex({ "device_id": 1 });
db.SensorLogs.createIndex({ "timestamp": 1 });

// Example query to verify indexes
db.SensorLogs.getIndexes();

// Example query to fetch logs for a specific device
db.SensorLogs.find({ "device_id": 1 }).sort({ "timestamp": -1 });