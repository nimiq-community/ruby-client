=begin
  Copyright 2020 Nimiq community.

  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
=end

require "sorbet-runtime"
require_relative "types"

module Api
  attr_accessor :rpc
  extend T::Sig

  # accounts - Returns a list of addresses owned by client.
  sig { returns(T::Array[Types::Account]) }

  def accounts
    result = @rpc.request("accounts")
    return result
  end

  # block_number - Returns the height of most recent block.
  sig { returns(Integer) }

  def block_number
    result = @rpc.request("blockNumber")
    return result
  end

  # consensus - Returns information on the current consensus state.
  sig { returns(String) }

  def consensus
    result = @rpc.request("consensus")
    return result
  end

  # constant - Returns or overrides a constant value.
  # When no parameter is given, it returns the value of the constant.
  # When giving a value as parameter, it sets the constant to the given value.
  # To reset the constant to the default value, the parameter "reset" should be used.
  # - @param [String] name - The class and name of the constant. (format should be Class.CONSTANT)
  # - @param [Integer] value - The new value of the constant or "reset". (optional)
  sig { params(name: String, value: T.nilable(Integer)).returns(Integer) }

  def constant(name, value = nil)
    if value
      result = @rpc.request("constant", name, value)
    else
      result = @rpc.request("constant", name)
    end
    return result
  end

  # create_account - Creates a new account and stores its private key in the client store.
  sig { returns(Types::Wallet) }

  def create_account
    result = @rpc.request("createAccount")
    return result
  end

  # create_raw_transaction - Creates and signs a transaction without sending it.
  # The transaction can then be send via `send_raw_transaction` without accidentally replaying it.
  # - @param [TransactionObject] transaction - The transaction object.
  sig { params(transaction: Types::TransactionOutgoing).returns(String) }

  def create_raw_transaction(transaction)
    result = @rpc.request("createRawTransaction", transaction)
    return result
  end

  # NEW
  # get_raw_transaction_info - Checks signed_transaction raw information.
  # - @param [String] signed_transaction - The hex encoded signed transaction.
  sig { params(signed_transaction: String).returns(Object) }

  def get_raw_transaction_info(signed_transaction)
    result = @rpc.request("getRawTransactionInfo", signed_transaction)
    return result
  end

  # get_account - Returns details for the account of given address.
  # - @param [String] address - Address to get account details.
  sig { params(address: String).returns(Types::Account) }

  def get_account(address)
    result = @rpc.request("getAccount", address)
    return result
  end

  # get_balance - Returns the balance of the account of given address.
  # - @param [String] address - Address to check for balance.
  sig { params(address: String).returns(Integer) }

  def get_balance(address)
    result = @rpc.request("getBalance", address)
    return result
  end

  # get_block_by_hash - Returns information about a block by hash.
  # - @param [String] block_hash - Hash of the block to gather information on.
  # - @param [Boolean] full_transactions (optional) - If true it returns the full transaction objects, if false only the hashes of the transactions. (default false)
  sig { params(block_hash: String, full_transactions: T.nilable(T::Boolean)).returns(Types::Block) }

  def get_block_by_hash(block_hash, full_transactions = nil)
    if full_transactions
      result = @rpc.request("getBlockByHash", block_hash, full_transactions)
    else
      result = @rpc.request("getBlockByHash", block_hash)
    end
    return result
  end

  # get_block_by_number - Returns information about a block by block number.
  # - @param [Integer] block_number - The height of the block to gather information on.
  # - @param [Boolean] full_transactions (optional) - If true it returns the full transaction objects, if false only the hashes of the transactions. (default false)
  sig { params(block_number: Integer, full_transactions: T.nilable(T::Boolean)).returns(Types::Block) }

  def get_block_by_number(block_number, full_transactions = nil)
    if full_transactions
      result = @rpc.request("getBlockByNumber", block_number, full_transactions)
    else
      result = @rpc.request("getBlockByNumber", block_number)
    end
    return result
  end

  # get_block_template - Returns a template to build the next block for mining.
  # This will consider pool instructions when connected to a pool.
  # - @param [String] address (optional) - Address to use as a miner for this block. This overrides the address provided during startup or from the pool.
  # - @param [String] data_field (optional) - Hex-encoded value for the extra data field. This overrides the address provided during startup or from the pool.
  sig { params(address: T.nilable(Integer), data_field: T.nilable(String)).returns(Types::BlockTemplate) }

  def get_block_template(address = nil, data_field = nil)
    result = @rpc.request("getBlockTemplate")
    return result
  end

  # get_block_transaction_count_by_hash - Returns the number of transactions in a block from a block matching the given block hash.
  # - @param [String] block_hash - Hash of the block.
  sig { params(block_hash: String).returns(Integer) }

  def get_block_transaction_count_by_hash(block_hash)
    result = @rpc.request("getBlockTransactionCountByHash", block_hash)
    return result
  end

  # get_block_transaction_count_by_number - Returns the number of transactions in a block matching the given block number.
  # - @param [Integer] block_number - Height of the block.
  sig { params(block_number: Integer).returns(Integer) }

  def get_block_transaction_count_by_number(block_number)
    result = @rpc.request("getBlockTransactionCountByNumber", block_number)
    return result
  end

  # get_transaction_by_block_hash_and_index - Returns information about a transaction by block hash and transaction index position.
  # - @param [String] block_hash - Hash of the block containing the transaction.
  # - @param [Integer] transaction_index - Index of the transaction in the block.
  sig { params(block_hash: String, transaction_index: Integer).returns(T.nilable(Types::Transaction)) }

  def get_transaction_by_block_hash_and_index(block_hash, transaction_index)
    result = @rpc.request("getTransactionByBlockHashAndIndex", block_hash, transaction_index)
    return result
  end

  # get_transaction_by_block_number_and_index - Returns information about a transaction by block number and transaction index position.
  # - @param [Integer] block_hash_index - Height of the block containing the transaction.
  # - @param [Integer] transaction_index - Index of the transaction in the block.
  sig { params(block_hash_index: Integer, transaction_index: Integer).returns(T.nilable(Types::Transaction)) }

  def get_transaction_by_block_number_and_index(block_hash_index, transaction_index)
    result = @rpc.request("getTransactionByBlockNumberAndIndex", block_hash_index, transaction_index)
    return result
  end

  # get_transaction_by_hash - Returns the information about a transaction requested by transaction hash.
  # - @param [String] transaction_hash - Hash of a transaction.
  sig { params(transaction_hash: String).returns(T.nilable(Types::Transaction)) }

  def get_transaction_by_hash(transaction_hash)
    result = @rpc.request("getTransactionByHash", transaction_hash)
    return result
  end

  # get_transaction_receipt - Returns the receipt of a transaction by transaction hash.
  # Note That the receipt is not available for pending transactions.
  # - @param [String] transaction_hash - Hash of a transaction.
  sig { params(transaction_hash: String).returns(T.nilable(Types::TransactionReceipt)) }

  def get_transaction_receipt(transaction_hash)
    result = @rpc.request("getTransactionReceipt", transaction_hash)
    return result
  end

  # get_transactions_by_address - Returns the latest transactions successfully performed by or for an address.
  # - @param [String] address - Address of which transactions should be gathered.
  # - @param [Integer] transactions_number (optional) - Number of transactions that shall be returned. (default 1000)
  sig { params(address: String, transactions_number: T.nilable(Integer)).returns(T.nilable(T::Array[Types::Transaction])) }

  def get_transactions_by_address(address, transactions_number = nil)
    if transactions_number
      result = @rpc.request("getTransactionsByAddress", address, transactions_number)
    else
      result = @rpc.request("getTransactionsByAddress", address)
    end
    return result
  end

  # get_work - Returns instructions to mine the next block. This will consider pool instructions when connected to a pool.
  # - @param [String] address (optional) - Address to use as a miner for this block. This overrides the address provided during startup or from the pool.
  # - @param [String] data_field (optional) - Hex-encoded value for the extra data field. This overrides the address provided during startup or from the pool.
  sig { params(address: T.nilable(String), data_field: T.nilable(String)).returns(Types::MiningWork) }

  def get_work(address = nil, data_field = nil)
    result = @rpc.request("getWork", address, data_field)
    return result
  end

  # hashrate - Returns the number of hashes per second that the node is mining with.
  sig { returns(T.any(Integer, Float)) }

  def hashrate
    result = @rpc.request("hashrate")
    return result
  end

  # log - Sets the log level of the node.
  # - @param [String] tag - If the tag is '*' the log level will be set globally, otherwise the log level is applied only on this tag.
  # - @param [String] log_level - Log levels valid options: `trace`, `verbose`, `debug`, `info`, `warn`, `error`, `assert`.
  sig { params(tag: String, log_level: String).returns(T::Boolean) }

  def log(tag, log_level)
    result = @rpc.request("log", tag, log_level)
    return result
  end

  # mempool - Returns information on the current mempool situation. This will provide an overview of the number of transactions sorted into buckets based on their fee per byte (in smallest unit).
  sig { returns(Object) }

  def mempool
    result = @rpc.request("mempool")
    return result
  end

  # mempool_content - Returns transactions that are currently in the mempool.
  sig { params(include_full_transactions: T.nilable(T::Boolean)).returns(T.any(T.nilable(T::Array[Types::Transaction]), T.nilable(T::Array))) }

  def mempool_content(include_full_transactions = nil)
    result = @rpc.request("mempoolContent")
    return result
  end

  # miner_address - Returns the miner address.
  sig { returns(String) }

  def miner_address
    result = @rpc.request("minerAddress")
    return result
  end

  # miner_threads - Returns or sets the number of CPU threads for the miner.
  # - @param [Integer] set_threads (optional) - The number of threads to allocate for mining.
  sig { params(set_threads: T.nilable(Integer)).returns(Integer) }

  def miner_threads(set_threads = nil)
    if set_threads
      result = @rpc.request("minerThreads", set_threads)
    else
      result = @rpc.request("minerThreads")
    end
    return result
  end

  # min_fee_per_byte - Returns or sets the minimum fee per byte.
  # - @param [Integer] set_min_fee (optional) - The new minimum fee per byte.
  sig { params(set_min_fee: T.nilable(Integer)).returns(Integer) }

  def min_fee_per_byte(set_min_fee = nil)
    if set_min_fee
      result = @rpc.request("minFeePerByte", set_min_fee)
    else
      result = @rpc.request("minFeePerByte")
    end
    return result
  end

  # mining - Returns `true` if client is actively mining new blocks.
  sig { returns(T::Boolean) }

  def mining
    result = @rpc.request("mining")
    return result
  end

  # peer_count - Returns number of peers currently connected to the client.
  sig { returns(Integer) }

  def peer_count
    result = @rpc.request("peerCount")
    return result
  end

  # peer_list - Returns list of peers known to the client.
  sig { returns(T::Array[Types::Peer]) }

  def peer_list
    result = @rpc.request("peerList")
    return result
  end

  # peer_state - Returns the state of the peer.
  # - @param [String] peer_address - The address of the peer.
  sig { params(peer_address: String).returns(Types::Peer) }

  def peer_state(peer_address)
    result = @rpc.request("peerState", peer_address)
    return result
  end

  # pool - Returns or sets the mining pool.
  # When no parameter is given, it returns the current mining pool. When a value is given as parameter, it sets the mining pool to that value.
  # - @param [String/Boolean] pool_address (optional) - The mining pool connection string (url:port) or boolean to enable/disable pool mining.
  sig { params(pool_address_or_action: T.nilable(T.any(String, T::Boolean))).returns(T.nilable(String)) }

  def pool(pool_address_or_action = nil)
    if pool_address_or_action
      result = @rpc.request("pool", pool_address_or_action)
    else
      result = @rpc.request("pool")
    end
    return result
  end

  # pool_confirmed_balance - Returns the confirmed mining pool balance.
  sig { returns(Integer) }

  def pool_confirmed_balance
    result = @rpc.request("poolConfirmedBalance")
    return result
  end

  # pool_connection_state - Returns the connection state to mining pool.
  sig { returns(Integer) }

  def pool_connection_state
    result = @rpc.request("poolConnectionState")
    return result
  end

  # send_raw_transaction - Sends a signed message call transaction or a contract creation, if the data field contains code.
  # - @param [String] signed_transaction - The hex encoded signed transaction.
  sig { params(signed_transaction: String).returns(Object) }

  def send_raw_transaction(signed_transaction)
    result = @rpc.request("sendRawTransaction", signed_transaction)
    return result
  end

  # send_transaction - Creates new message call transaction or a contract creation, if the data field contains code.
  # - @param [TransactionObject] transaction - The transaction object.
  sig { params(transaction: Types::TransactionOutgoing).returns(String) }

  def send_transaction(transaction)
    result = @rpc.request("sendTransaction", transaction)
    return result
  end

  # submit_block - Submits a block to the node. When the block is valid, the node will forward it to other nodes in the network.
  # When submitting work from getWork, remember to include the suffix.
  # - @param [String] block - Hex-encoded full block (including header, interlink and body).
  sig { params(block: String) }

  def submit_block(block)
    result = @rpc.request("submitBlock", block)
    return result
  end

  # syncing - Returns an object with data about the sync status or `false`.
  sig { returns(T.any(Object, T::Boolean)) }

  def syncing
    result = @rpc.request("syncing")
    return result
  end
end
