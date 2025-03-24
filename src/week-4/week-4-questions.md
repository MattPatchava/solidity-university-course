Q: Why use contractCount instead of just qualityContracts.length? Adding another variable is a potential point of error if you forget to update it.
A: The `mapping` types does not have any kind of `.length` property.

Q: createQualityContract is a public function that does not modify its parameters – it simply passes them to the struct constructor of QualityContractCreated and assigns that to a new key in the hashmap. So, couldn't they be marked as `calldata` instead of `memory`?
A: They should be marked `calldata` instead of `memory`.

Q: The QualityContractData struct has what looks to be a constructor that is called in createQualityContract. However, this was never declared/defined – does it just assign its parameters to its fields in the order that the fields were declared?
A: Yes, it is automatically generated. Solidity automatically creates a constructor-like instantiation function based on field declaration order.

Q: I have learned about storage location specifiers in function signatures but not return types. getQualityContractDetails returns two strings and an array of addresses, all of which are marked `memory`. Does this simply mean that the values are returned, rather than references/pointers to these objects? And is the `bool` not assigned a location specifier since it is primitive and therefore returned as a value by default?
A: string and address[] are reference types, so you need to specify whether to return their value or a reference/pointer to them. bool is a value type so it is returned by value automatically. In short, specifying `memory` on return types returns the variable's value, not reference.

Q: In getQualityContractDetails, the contractData variable is marked as `storage`. But it is declared locally, so would it not be stored in memory only (i.e., on the EVM's stack)? If it is actually being stored in storage, how does this even work?
A: Local variables **default** to memory. In this case, that would create a copy of `qualityContracts[_contractId]. However, we want it to point to/reference the qualityContracts[_contractId] on-chain. That is why it is marked `storage` – so that a reference, not a copy, is created.
