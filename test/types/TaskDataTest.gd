# GdUnit generated TestSuite
#warning-ignore-all:unused_argument
#warning-ignore-all:return_value_discarded
class_name TaskDataTest
extends GdUnitTestSuite

# TestSuite generated from
const __source = 'res://src/types/TaskData.gd'

func test_setTaskName() -> void:
	var task_data: TaskData = load("res://src/types/TaskData.gd").new(1, "Hello_there", 0)
	assert_str(task_data.getTaskName()).is_equal("Hello_there")
