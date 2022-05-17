# Working with CSV in Bicep

This sample shows how to create resources from a basic CSV input file.

```csv
name,ip
testnic,10.1.1.1
anothernic,10.1.1.2
```

## What-if result

```text
The deployment will update the following scope:

Scope: /subscriptions/REDACTED/resourceGroups/Innerloop

  + Microsoft.Network/networkInterfaces/nic-anothernic [2021-08-01]

      apiVersion:  "2021-08-01"
      id:          "/subscriptions/REDACTED/resourceGroups/Innerloop/providers/Microsoft.Network/networkInterfaces/nic-anothernic"
      name:        "nic-anothernic"
      properties.ipConfigurations: [
        0:

          properties.privateIPAddress: "10.1.1.2"

      ]
      type:        "Microsoft.Network/networkInterfaces"

  + Microsoft.Network/networkInterfaces/nic-testnic [2021-08-01]

      apiVersion:  "2021-08-01"
      id:          "/subscriptions/REDACTED/resourceGroups/Innerloop/providers/Microsoft.Network/networkInterfaces/nic-testnic"
      name:        "nic-testnic"
      properties.ipConfigurations: [
        0:

          properties.privateIPAddress: "10.1.1.1"

      ]
      type:        "Microsoft.Network/networkInterfaces"

```