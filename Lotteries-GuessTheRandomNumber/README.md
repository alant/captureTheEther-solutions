Here is the solution. Replace # contract address with the actual contract address deployed in the challenge.

```Javascript
web3.eth.getStorageAt('# contract address', 0, (err,res)=>{if (err) {console.log(err);} else {console.log(`0: uint8: ${web3.toDecimal(res)}`);}});
```
Here are some relevant exploratory code for my own reference.
```Javascript
var txHash = '# hash'; web3.eth.getTransaction(txHash, (err, tx) => { console.log(tx); var blockNumber = tx.blockNumber; web3.eth.getBlock(blockNumber, (err, block) => { console.log(block); var timestamp = block.timestamp; var parentHash = block.parentHash; var hash = web3.sha3(parentHash + web3.padLeft(timestamp.toString(16), 64),  {encoding: 'hex'}); console.log(web3.toDecimal(hash.slice(-2)));  }); });
web3.eth.getTransaction(txHash, (err, tx) => { console.log(tx); });
web3.eth.getTransaction(txHash, (err, tx) => { var blockNumber = tx.blockNumber; web3.eth.getBlock(blockNumber, (err, block) => { console.log(block); }) });
web3.eth.getTransaction(txHash, (err, tx) => { var blockNumber = tx.blockNumber; web3.eth.getBlock(blockNumber, (err, block) => { var timestamp = block.timestamp; var parentHash = block.parentHash; var hash = web3.sha3(parentHash + web3.padLeft((timestamp).toString(16), 64)); console.log(hash.slice(-2)); }) });
```
