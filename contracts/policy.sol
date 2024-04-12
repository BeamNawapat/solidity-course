// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Policy {
	event PolicyUpdated(address indexed policyholder, Status status);

	enum Status {
		Pending, // value = 0
		Accepted, // value = 1
		Rejected, // value = 2
		Cancelled // value = 3
	}

	struct PolicyData {
		address policyholder;
		Status status;
		uint40 createdAt;
		uint40 updatedAt;
	}

	modifier onlyPending(address _policyholder) {
		require(
			_policies[_policyholder].status == Status.Pending,
			"Policy: Policy is not pending"
		);
		_;
	}

	mapping(address => PolicyData) internal _policies;

	function updateData(address _policyholder, Status status) public {
		require(
			_policies[_policyholder].status == Status.Pending,
			"Policy: Policy is not pending"
		);

		require(
			status != Status.Pending,
			"Policy: The new status cannot be pending"
		);

		_policies[_policyholder].status = status;
	}

	function updateDataWithModifier(
		address _policyholder,
		Status status
	) public onlyPending(_policyholder) {
		require(
			status != Status.Pending,
			"Policy: The new status cannot be pending"
		);

		_policies[_policyholder].status = status;
	}

	function getData(
		address _policyholder
	) public view returns (PolicyData memory) {
		return _policies[_policyholder];
	}
}
