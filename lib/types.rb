require "sorbet-runtime"

# :nodoc: all
module Types
  extend T::Sig

  Block = {
    number: Integer,
    hash: String,
    pow: String,
    parentHash: String,
    nonce: Integer,
    bodyHash: String,
    accountsHash: String,
    miner: String,
    minerAddress: String,
    difficulty: String,
    extraData: String,
    size: Integer,
    timestamp: Integer,
    transactions: Array,
    confirmations: T.nilable(Integer),
  }

  BlockTemplate = {
    header: {
      version: Integer,
      prevHash: String,
      interlinkHash: String,
      accountsHash: String,
      nBits: Integer,
      height: Integer,
    },
    interlink: String,
    body: {
      hash: String,
      minerAddr: String,
      extraData: String,
      transactions: T::Array[String],
      prunedAccounts: T::Array[String],
      merkleHashes: T::Array[String],
    },
    target: Integer,
  }

  Wallet = {
    id: String,
    address: String,
    publicKey: String,
  }

  Account = {
    id: String,
    address: String,
    balance: Integer,
    type: Integer,
  }

  Transaction = {
    hash: String,
    blockHash: T.nilable(String),
    blockNumber: T.nilable(Integer),
    timestamp: T.nilable(Integer),
    confirmations: T.nilable(Integer),
    transactionIndex: T.nilable(Integer),
    from: String,
    fromAddress: String,
    to: String,
    toAddress: String,
    value: Integer,
    fee: Integer,
    data: T.nilable(String),
    flags: Integer,
  }

  TransactionOutgoing = {
    from: String,
    to: String,
    value: Integer,
    fee: Integer,
  }

  TransactionReceipt = {
    transactionHash: String,
    transactionIndex: Integer,
    blockNumber: Integer,
    blockHash: String,
    confirmations: Integer,
    timestamp: Integer,
  }

  MiningWork = {
    data: String,
    suffix: String,
    target: Integer,
    algorithm: String,
  }

  Peer = {
    id: String,
    address: String,
    addressState: Integer,
    connectionState: T.nilable(Integer),
    version: T.nilable(Integer),
    timeOffset: T.nilable(Integer),
    headHash: T.nilable(String),
    latency: T.nilable(Integer),
    rx: T.nilable(Integer),
    tx: T.nilable(Integer),
  }
end
