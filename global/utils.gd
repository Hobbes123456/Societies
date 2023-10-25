extends Node

func assemble_linked_lists(keys: Array, values: Array) -> Dictionary:
	@warning_ignore("unassigned_variable")
	var res: Dictionary
	for i in range(len(keys)):
		if i < len(values):
			res[keys[i]] = values[i]
	return res
