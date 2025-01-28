
# A fully automated Python script using the Azure CLI and az command to fetch all accepted marketplace agreements for the publisher "fortinet" on the current subscription.
# This script uses subprocess to call Azure CLI commands and parses the results to determine the agreement acceptance status.

import subprocess
import json

def get_accepted_agreements(publisher):
    location = "westeurope"  # Specify your desired Azure region

    try:
        # Fetch all offers for the publisher
        offers_output = subprocess.check_output(
            ["az", "vm", "image", "list-offers", "--location", location, "--publisher", publisher, "--query", "[].name", "-o", "json"],
            stderr=subprocess.STDOUT
        )
        offers = json.loads(offers_output)

        accepted_agreements = []

        # Loop through each offer to fetch SKUs and agreement status
        for offer in offers:
            skus_output = subprocess.check_output(
                ["az", "vm", "image", "list-skus", "--location", location, "--publisher", publisher, "--offer", offer, "--query", "[].name", "-o", "json"],
                stderr=subprocess.STDOUT
            )
            skus = json.loads(skus_output)

            for sku in skus:
                # Check agreement status
                terms_output = subprocess.check_output(
                    ["az", "vm", "image", "terms", "show", "--publisher", publisher, "--offer", offer, "--sku", sku, "-o", "json"],
                    stderr=subprocess.STDOUT
                )
                terms = json.loads(terms_output)

                if terms.get("accepted", False):
                    accepted_agreements.append({
                        "offer": offer,
                        "sku": sku,
                        "publisher": publisher,
                        "location": location
                    })

        return accepted_agreements

    except subprocess.CalledProcessError as e:
        print(f"Error executing Azure CLI command: {e.output.decode('utf-8')}")
        return []

if __name__ == "__main__":
    publisher = "fortinet"
    agreements = get_accepted_agreements(publisher)

    if agreements:
        print("Accepted Marketplace Agreements:")
        for agreement in agreements:
            print(f"Publisher: {agreement['publisher']}, Offer: {agreement['offer']}, SKU: {agreement['sku']}, Location: {agreement['location']}")
    else:
        print("No accepted marketplace agreements found for the specified publisher.")
