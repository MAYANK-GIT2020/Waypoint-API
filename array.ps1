#$array.lenght --> to find array lenght
#$array[index number] --> to access item from array by index starting from 0


$a = 10
$b = 10, 11
$a.GetType()
$b.GetType()

#or

$b = @(10, 11)
$b.GetType()
$b | Get-Member

$boys = @("Mayank", "shashank", "rajat","Tripathi")
$boys
$boys.GetType()
$boys.Length
$boys[0]
$boys[1..4]

$girl = @("komal","himani","ritika","vandana")
$girl
$girl.Length
$girl[2]
$girl[1..3]

$array_total = $girl + $boys
$array_total
$array_total.Contains("himani") # returns true or false 

$array_total.IsSynchronized #
$array_total.IsFixedSize # to check array is fixed sized or not
$array_total.Add("1") #to add additional member to array


############Array LIST ###################

# To add element, remove element, modify existing array and search

# Class = system.collection.arraylist


$new = New-Object System.Collections.ArrayList
$new = (1,2,3,4,5,6)
$new.Add("7")
$new

$ser = @(Get-Service | Select-Object Name,Status )
$ser.Length
$ser[100..200] | Out-File C:\temp\servicename.txt