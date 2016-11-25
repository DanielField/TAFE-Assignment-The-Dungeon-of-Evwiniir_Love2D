 -- Returns the difference between two numbers
function getDifference(num1,num2)
	if num1 > num2 then
		return num1 - num2
	else
		return num2 - num1 
	end
end

-- This function splits a string up by the specified delimiter
-- RETURNS: table of all of the split values
function split(s, delimiter)
    result = {}
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match)
    end
    return result
end