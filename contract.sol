contract GolemPay {
	mapping(address => uint) balances;
	
	function pay(uint taskId, address[] addresses, uint[] payments) {
		for (uint i = 0; i < addresses.length; ++i) {
			balances[addresses[i]] += payments[i];
		}
	}
	
	function getBalance() constant returns(uint balance) {
		return balances[tx.origin];
	}
}
