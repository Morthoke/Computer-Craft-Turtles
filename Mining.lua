-- Check if there is any items in inventory
function inventoryCheck()
	local full = false
	for  i = 1, 16 do
		if turtle.getItemCount(i) == 0 then
			full = true
		end
	end
	return full
end

-- Empty All slots apart from fuel (Coal Slot)
function emptyInventory()
	for i = 2, 16  do
		turtle.select(i)
		turtle.drop()
	end
end

-- Fuel
function fuel()
	turtle.select(1)
	if turtle.refuel(0) then
		local halfstack = math.ceil(turtle.getItemCount(i)/2) -- Halfs amount in the slot
		turtle.refuel(halfstack)
	end
end


-- Return Home
function babyComeBack(x, y, z)
	local xt, yt, zt = gps.locate(5)	
	-- Move Turtle Along X and Z first
	go(x , yt , z)
	-- Move Along Y Second
	go(x, y, z)

end

-- Get Area that is going to be mined and y lvl
function input()
	-- Get y Level
	io.write('Please Enter the Y Level: ')
	local y = io.read()

	-- Get Length 1
	io.write('Please Enter Length 1: ')
	local x = io.read()

	-- get Length 2
	io.write('Please Enter Length 2: ')
	local z = io.read()

	-- Mining Size 
	-- L1 x L2 x 3
	local totalSize = 3 * x * z
	totalSize = math.abs(totalSize)
	io.write('Total Amount of Blocks to be Mined: ', totalSize)

	--Debug
	--io.write('y = ', y, ' x = ', x,' z = ', z, 'totalSize = ', totalSize)
	return y, x, z
end

-- Mine
function diggyHole(distance)
	local function defualt()
		turtle.dig()
		turtle.forward()
		turtle.digUp()
		turtle.digDown()
	end

	if distance > 0 then 

		distance = distance + 1 
		for i=1, distance do
			diggyHole().defualt()
		end

		-- Turn Right And Dig
		turtle.turnRight()
		diggyHole().defualt()

		-- Face Next Dig Direction
		turtle.turnRight()

		distance = distance - 1 
		for i=1, distance do
			diggyHole().defualt()
		end

		--Turn Left and Dig
		turtle.turnLeft()
		diggyHole().defualt()

		--Face Next Dig Direction
		turtle.turnLeft()
	end
end


-- Mine Out the Area
function doTheThing(x, z)
	
	-- Even Number of Rows
	if (z % 2 == 0) then

		-- Start For Loop
		for i = 1, z do
			diggyHole(z)

			--Inv Check in case full
			if inventoryCheck() then
				--Go back to dump items then return to continue
			end
			-- Fuel Check
			fuel()
		end


	-- Odd Number Of Rows
	else
    	z = z - 1
    	-- Start For Loop
    	for i = 1, z do
    		--Dig Section
    		diggyHole(z)
    		diggyHole(0).defualt() -- Extra for the last roy

    		--Inv Check in case full
			if inventoryCheck() then
				--Go back to dump items then return to continue
			end
			-- Fuel Check
			fuel()
    	end
	end
end

