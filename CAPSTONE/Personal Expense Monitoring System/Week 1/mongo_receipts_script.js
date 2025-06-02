// Use or create the database
use ExpenseDB;

// Define the Receipts collection
const receipts = db.Receipts;

// Insert a sample receipt document
receipts.insertOne({
  user_id: ObjectId("60c5ba2e5f9e3c06b8f5a1d0"), // Replace with actual ObjectId if needed
  date: new Date("2025-06-01"),
  category: "Groceries",
  notes: "Bought from SuperMart",
  receipt: {
    store: "SuperMart",
    items: [
      { item: "Rice", price: 200 },
      { item: "Milk", price: 50 }
    ],
    total: 250
  }
});

// Create indexes for quick lookups
receipts.createIndex({ user_id: 1 });
receipts.createIndex({ "receipt.store": 1 });

// Confirmation log
print("Sample receipt inserted and indexes created successfully.");