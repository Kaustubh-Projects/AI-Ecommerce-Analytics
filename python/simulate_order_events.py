
import random
import uuid
from datetime import datetime
from pathlib import Path

import pandas as pd

from ingest_order_events import load_order_events, engine


# 1. Define project folders
project_folder = Path(__file__).resolve().parent.parent
incoming_folder = project_folder / "data" / "incoming"

incoming_folder.mkdir(parents=True, exist_ok=True)

# 2. Choose how many events to generate
number_of_events = 5

# 3. Define possible order statuses
order_statuses = ["created", "approved", "processing"]

# 4. Generate synthetic order events
events = []

for _ in range(number_of_events):
    event = {
        "event_id": str(uuid.uuid4()),
        "order_id": f"SIM-{uuid.uuid4().hex[:8]}",
        "customer_id": f"CUST-{random.randint(1000, 9999)}",
        "order_status": random.choice(order_statuses),
        "order_purchase_timestamp": datetime.now().strftime(
            "%Y-%m-%d %H:%M:%S"
        ),
    }

    events.append(event)

# 5. Save the generated events to a new CSV file
timestamp = datetime.now().strftime("%Y%m%d_%H%M%S_%f")
csv_path = incoming_folder / f"simulated_events_{timestamp}.csv"

pd.DataFrame(events).to_csv(csv_path, index=False)

print(f"Generated {number_of_events} synthetic events.")
print(f"CSV saved to: {csv_path}")

# 6. Send the generated events into Bronze
try:
    load_order_events(csv_path, "simulated")
finally:
    engine.dispose()