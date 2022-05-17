var csvfilename = 'nics.csv'
var file = loadTextContent(csvfilename)
var eachrow = split(file,'\r\n')

resource bunchOfNics 'Microsoft.Network/networkInterfaces@2021-08-01' = [for (nic, i) in eachrow : if (i > 0) {
  name: 'nic-${split(nic,',')[0]}'
  properties: {
    ipConfigurations: [
      {
        properties: {
          privateIPAddress: split(nic,',')[1]
        }
      }
    ]
  }
}]

output fileout string = file
output linesout array = eachrow
