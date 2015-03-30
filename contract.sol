contract GolemPay {
	mapping(address => uint) balances;
	
	event Payment(uint indexed taskId, address indexed from, address indexed to, uint value);
	
	function pay(uint taskId, address[] addresses, uint[] payments) external {
		balances[msg.sender] += msg.value;
		
		if (addresses.length != payments.length)
			return;
		
		uint sum = 0;
		for (uint j = 0; j != payments.length; ++j) {
			sum += payments[j];
		}
		
		if (balances[msg.sender] >= sum) {
			balances[msg.sender] -= sum;
			for (uint i = 0; i != addresses.length; ++i) {
				balances[addresses[i]] += payments[i];
				Payment(taskId, msg.sender, addresses[i], payments[i]);
			}
		}
	}
	
	function getBalance() constant returns(uint balance) {
		return balances[msg.sender];
	}
}
