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

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "ruby-client"
# require "minitest/autorun"

describe "Nimiq", type: :request do

  # Initialize
  before(:all) do
    options = {
      host: "localhost",
      port: 8005,
      user: "user",
      pass: "pass",
    # dev: true,
    }
    @signed_transaction = "010000...abcdef"
    @nimiq = Nimiq::Client.new(options)
  end

  # Test suite for client
  describe "RPC Client" do

    # Test suite for client version
    it "Must have a version." do
      expect(::Nimiq::VERSION).not_to eq(nil)
    end

    # Test suite for client connection
    it "Must be able to connect to the Nimiq node." do
      expect(@nimiq.ping).to eq(200)
    end

    # Test suite for client to send raw requests
    it "Must be able to send raw requests." do
      expect(@nimiq.request("consensus")).to be_a_kind_of(String)
    end
  end

  # Test suite for api
  describe "Api" do

    # Test suite for client to retrieve the addresses owned by client.
    it "Must be able to retrieve addresses owned by client." do
      expect(@nimiq.accounts()).to be_a_kind_of(Object)
    end

    # Test suite for client to retrieve height of most recent block.
    it "Must be able to retrieve height of most recent block." do
      expect(@nimiq.block_number()).to be_a_kind_of(Object)
    end

    # Test suite for client to retrieve the consensus status.
    it "Must be able to retrieve the consensus status." do
      expect(@nimiq.consensus()).to be_a_kind_of(String)
    end

    # Test suite for client to override a constant value.
    it "Must be able to override a constant value." do
      constant_value = 10
      expect(@nimiq.constant("BaseConsensus.MAX_ATTEMPTS_TO_FETCH", constant_value)).to eq(constant_value)
    end

    # Test suite for client to retrieve a constant value.
    it "Must be able to retrieve a constant value." do
      expect(@nimiq.constant("BaseConsensus.MAX_ATTEMPTS_TO_FETCH")).to eq(10)
    end

    # Test suite for client to create a new account.
    it "Must be able to create a new account." do
      expect(@nimiq.create_account()).to be_a_kind_of(Object)
    end

    # Test suite for client to create a transaction without sending it.
    it "Must be able to create a transaction without sending it." do
      transaction = {
        "from": "NQ94 VESA PKTA 9YQ0 XKGC HVH0 Q9DF VSFU STSP",
        "to": "NQ16 61ET MB3M 2JG6 TBLK BR0D B6EA X6XQ L91U",
        "value": 100000,
        "fee": 0,
      }
      expect(@nimiq.create_raw_transaction(transaction)).to be_a_kind_of(Object)
    end

    # # new
    # # Test suite for client to retrieve a transaction information.
    # it "Must be able to retrieve a transaction information." do
    #   # signed_transaction = "010000...abcdef"
    #   expect(@nimiq.get_raw_transaction_info(@signed_transaction)).to be_a_kind_of(Object)
    # end

    # Test suite for client to retrieve information related to an account.
    it "Must be able to retrieve information related to an account." do
      expect(@nimiq.get_account("NQ30 JLD6 U347 DFVU 40J3 F93V 9TCF YMMX RKY3")).to be_a_kind_of(Object)
    end

    # Test suite for client to retrieve balance of account.
    it "Must be able to retrieve balance of account." do
      expect(@nimiq.get_balance("NQ30 JLD6 U347 DFVU 40J3 F93V 9TCF YMMX RKY3")).to be_a_kind_of(Numeric)
    end

    # Test suite for client to retrieve block by hash.
    it "Must be able to retrieve block by hash." do
      expect(@nimiq.get_block_by_hash("14c91f6d6f3a0b62271e546bb09461231ab7e4d1ddc2c3e1b93de52d48a1da87", false)).to be_a_kind_of(Object)
    end

    # Test suite for client to retrieve block by hash, full transactions included.
    it "Must be able to retrieve block by hash, full transactions included." do
      expect(@nimiq.get_block_by_hash("14c91f6d6f3a0b62271e546bb09461231ab7e4d1ddc2c3e1b93de52d48a1da87", true)).to be_a_kind_of(Object)
    end

    # Test suite for client to retrieve block by number.
    it "Must be able to retrieve block by number." do
      expect(@nimiq.get_block_by_number(76415, false)).to be_a_kind_of(Object)
    end

    # Test suite for client to retrieve block by number, full transactions included.
    it "Must be able to retrieve block by number, full transactions included." do
      expect(@nimiq.get_block_by_number(76415, true)).to be_a_kind_of(Object)
    end

    # Test suite for client to retrieve block template.
    it "Must be able to retrieve block template." do
      expect(@nimiq.get_block_template()).to be_a_kind_of(Object)
    end

    # Test suite for client to retrieve the number of transactions in a block by block hash.
    it "Must be able to retrieve the number of transactions in a block by block hash." do
      expect(@nimiq.get_block_transaction_count_by_hash("dfe7d166f2c86bd10fa4b1f29cd06c13228f893167ce9826137c85758645572f")).to be_a_kind_of(Numeric)
    end

    # Test suite for client to retrieve the number of transactions in a block by block number.
    it "Must be able to retrieve the number of transactions in a block by block number." do
      expect(@nimiq.get_block_transaction_count_by_number(76415)).to be_a_kind_of(Numeric)
    end

    # Test suite for client to retrieve information about a transaction by block hash and transaction index position.
    it "Must be able to retrieve information about a transaction by block hash and transaction index position." do
      expect(@nimiq.get_transaction_by_block_hash_and_index("dfe7d166f2c86bd10fa4b1f29cd06c13228f893167ce9826137c85758645572f", 20)).to be_a_kind_of(Object)
    end

    # Test suite for client to retrieve information about a transaction by block number and transaction index position.
    it "Must be able to retrieve information about a transaction by block number and transaction index position." do
      expect(@nimiq.get_transaction_by_block_number_and_index(76415, 20)).to be_a_kind_of(Object)
    end

    # Test suite for client to retrieve the information about a transaction requested by transaction hash.
    it "Must be able to retrieve the information about a transaction requested by transaction hash." do
      expect(@nimiq.get_transaction_by_hash("9eb228482138a8e64c5bb60608979904aa2be5721c115a9e3db54a0c481bb398")).to be_a_kind_of(Object)
    end

    # Test suite for client to retrieve the receipt of a transaction by transaction hash.
    it "Must be able to retrieve the receipt of a transaction by transaction hash." do
      expect(@nimiq.get_transaction_receipt("465a63b73aa0b9b54b777be9a585ea00b367a17898ad520e1f22cb2c986ff554")).to be_a_kind_of(Object)
    end

    # Test suite for client to retrieve the latest transactions successfully performed by or for an address.
    it "Must be able to retrieve the latest transactions successfully performed by or for an address." do
      expect(@nimiq.get_transactions_by_address("NQ699A4AMB83HXDQ4J46BH5R4JFFQMA9C3GN", 100)).to be_a_kind_of(Object)
    end

    # Test suite for client to retrieve instructions to mine the next block.
    it "Must be able to retrieve instructions to mine the next block." do
      expect(@nimiq.get_work()).to be_a_kind_of(Object)
    end

    # Test suite for client to retrieve the number of hashes per second that the node is mining with.
    it "Must be able to retrieve the number of hashes per second that the node is mining with." do
      expect(@nimiq.hashrate()).to be_a_kind_of(Numeric)
    end

    # Test suite for client to set the log level of the node.
    it "Must be able to set the log level of the node." do
      expect(@nimiq.log("BaseConsensus", "debug")).to be(true).or be(false)
    end

    # Test suite for client to retrieve information on the current mempool situation.
    it "Must be able to retrieve information on the current mempool situation." do
      expect(@nimiq.mempool()).to be_a_kind_of(Object)
    end

    # Test suite for client to retrieve transactions that are currently in the mempool.
    it "Must be able to retrieve transactions that are currently in the mempool." do
      expect(@nimiq.mempool_content()).to be_a_kind_of(Object)
    end

    # Test suite for client to retrieve miner address.
    it "Must be able to retrieve miner address." do
      expect(@nimiq.miner_address()).to be_a_kind_of(String)
    end

    # Test suite for client to set the number of CPU threads for the miner.
    it "Must be able to set the number of CPU threads for the miner." do
      expect(@nimiq.miner_threads(2)).to be_a_kind_of(Numeric)
    end

    # Test suite for client to retrieve the number of CPU threads for the miner.
    it "Must be able to retrieve the number of CPU threads for the miner." do
      expect(@nimiq.miner_threads()).to be_a_kind_of(Numeric)
    end

    # Test suite for client to set the minimum fee per byte.
    it "Must be able to set the minimum fee per byte." do
      expect(@nimiq.min_fee_per_byte(1)).to be_a_kind_of(Numeric)
    end

    # Test suite for client to retrieve the minimum fee per byte.
    it "Must be able to retrieve the minimum fee per byte." do
      expect(@nimiq.min_fee_per_byte()).to be_a_kind_of(Numeric)
    end

    # Test suite for client to retrieve if client is actively mining new blocks.
    it "Must be able to retrieve if client is actively mining new blocks." do
      expect(@nimiq.mining()).to be(true).or be(false)
    end

    # Test suite for client to retrieve the number of peers currently connected to the client.
    it "Must be able to retrieve the number of peers currently connected to the client." do
      expect(@nimiq.peer_count()).to be_a_kind_of(Numeric)
    end

    # Test suite for client to retrieve the list of peers known to the client.
    it "Must be able to retrieve the list of peers known to the client." do
      expect(@nimiq.peer_list()).to be_a_kind_of(Object)
    end

    # Test suite for client to retrieve the state of the peer.
    it "Must be able to retrieve the state of the peer." do
      expect(@nimiq.peer_state("wss://seed-1.nimiq.com:8443/dfd55fe967d6c0ca707d3a73ec31e4ac")).to be_a_kind_of(Object)
    end

    # Test suite for client to set the mining pool.
    it "Must be able to set the mining pool." do
      expect(@nimiq.pool("eu.nimpool.io:8444")).to be_a_kind_of(String)
    end

    # Test suite for client to retrieve the mining pool.
    it "Must be able to retrieve the mining pool." do
      expect(@nimiq.pool()).to be_a_kind_of(String)
    end

    # Test suite for client to retrieve the confirmed mining pool balance.
    it "Must be able to retrieve the confirmed mining pool balance." do
      expect(@nimiq.pool_confirmed_balance()).to be_a_kind_of(Numeric)
    end

    # Test suite for client to retrieve the connection state to mining pool.
    it "Must be able to retrieve the connection state to mining pool." do
      expect(@nimiq.pool_connection_state()).to be_a_kind_of(Numeric)
    end

    # Test suite for client to send a signed message call transaction or a contract creation, if the data field contains code.
    it "Must be able to send a signed message call transaction or a contract creation, if the data field contains code." do
      # signed_transaction = "010000...abcdef"
      expect(@nimiq.send_raw_transaction(@signed_transaction)).to be_a_kind_of(Object)
    end

    # Test suite for client to create new message call transaction or a contract creation, if the data field contains code.
    it "Must be able to create new message call transaction or a contract creation, if the data field contains code." do
      transaction = {
        "from": "NQ94 VESA PKTA 9YQ0 XKGC HVH0 Q9DF VSFU STSP",
        "to": "NQ16 61ET MB3M 2JG6 TBLK BR0D B6EA X6XQ L91U",
        "value": 100000,
        "fee": 0,
      }
      expect(@nimiq.send_transaction(transaction)).to be_a_kind_of(Object)
    end

    # Test suite for client to submit a block to the node.
    it "Must be able to submit a block to the node." do
      block = "00000000"
      expect(@nimiq.submit_block(block)).to be_a_kind_of(Numeric)
    end

    # Test suite for client to retrieve an object with data about the sync status.
    it "Must be able to retrieve an object with data about the sync status." do
      expect(@nimiq.syncing()).to be(true).or be(false)
    end
  end
end
