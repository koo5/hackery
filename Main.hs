
import Data.List
import Data.Char
import Data.Int
--import Prelude.Int prelude is imported by default. its Data.Int
--We'll worry about modules when it's done
--data InstrDetails  = InstrDetails {instrName :: String, opcode :: Int} --That should be sufficient

type MemLoc        = Int -- Used to specify a memory location as a decimal number
data Literal       = IntLit Int | CharLit Char -- Take a guess
		--back in a bit k
data Operand       = Loc MemLoc | Lit Literal -- An operand (or argument) of an assembly instruction 
type Opcode        = Int -- The opcode of an instruction
data InstrType     = Instr Opcode Operand Operand -- Instruction...
--data RegisterDef   = Register {name :: String, value :: [Int], id} --TODO?
type RegisterType  = Int -- wont memory be all of one type anyway? -- RegisterType; don't change
type Registers     = [RegisterType] --mayb this isnt C? maybe--reading..this should work -- Register contents
data VmType        = Vm {instrPointer :: Int, regs :: Registers} deriving (Show) -- Virtual machine instance description

--A few mathmatical functions that might come in handy some time

sqrt 0 = 0
sqrt n = n ** 0.5

--'Prototypes'

runBinary :: InstrType -> VmType -> VmType
--evalAsm   :: String -> Vm -> Vm -- TODO

--updated: returns an updated list; the change being at list !! pos which now contains val 

updated list pos val =
	take pos list ++ [val] ++ drop (pos + 1) list

---test0 (Instr a b c) z = print a
	

test1 = 
	let test = Vm 0 [3,4,5] in 
		print test

--char and int literals, should there be an implicit conversion from char literal to int literal # as in 'a' -> 97 ?
--as in add 'r' 4
--well add 'a' 3 should be 100 then? are the umm..when applying the add instruction, 

intval :: Operand -> Int

locval (Loc ( val)) = val

intval (Lit (IntLit val)) = val

regFromInt :: Int -> RegisterType
regFromInt x = x
--no idea --What do you *want* it to do?
--it doesnt want to match Int back to RegisterType
--so i want an explicit constructor...but im not sure what im doing

runBinary (Instr opcode op1 op2) (Vm ip regs) = case opcode of
	0 -> Vm (ip + 1) regs --we need to get the value field from the 
	1 -> Vm (ip + 1) --so, put to ACC the result.. lets say ACC is 0?
		(updated regs 0 (regFromInt ((intval op1)+(intval op2))))

parseStrToInstruction :: String -> InstrType 

parseStrToInstruction s = do
	{-
	Here's how it *will* work:
	1. split the string at spaces ("Hello world" becomes ["Hello", "World"])
	2. read the first 3 letters of the first item, and translate to opcode--you can skip that, then
	3. create a list with the first item (opcode) as the new first item, and the second and third items as the same
	4. take this list, and using it, create an Instr instance, which we return
	-}
--	i = x !! 0
	let x = words s --and if, ..anyway, we need to convert the strings of the operands into actual operands. but, do we do it individually in each opcode case, or in the let here?
	    i = x !! 0
	    
o1 = x !! 1
	    o2 = x !! 2 
	    o1ch = strToCharLiteral o1 in -- I presume strToCharLIteral returns the first character in a string? or an array of chars
		case i of
			"add" -> Instr 1 o1 o2
			"nop" -> Instr 0 -- ?hm, that wasnt the problem tho
		 
		--isnt haskell, like, lazy? couldnt we do let op1 = x!!1, op2 = x!!2 in ..
		--haskell is extremely lazy; you can have an infinite list (e.g., of all the fibbonacci numbers)
	--i = x
	--y = x !! 0:x !! 1:x !! 2 --without a simple slicing notation, this is the best i got. 3.
	--z = Instr y !! 0 y !! 1 y !! 2


testParse = 
	parseStrToInstruction "add 3 3" == Instr 1 3 3
	-- here, add takes two ints i suppose
	--some other instruction is gonna expect a char? 
	--or do we just always convert chars to ints?

--readAndExecuteOperationFromStr :: String -> VmType -> VmType

--readAndExectueOperationFromStr str vm = do
--	runBinary parseStrToInstruction vm

test2 = do
	testParse
	let myRegisters = [0]
	    vm          = Vm 0 myRegisters in do --Should work...
	    --print evalAsm "add x y" vm -- for later
	    --print $ runBinary Instr 0 00 0 vm --Right? will see.
            print $ runBinary (Instr 0 (Loc 0) (Lit (IntLit 0))) vm
	    let vm2 = runBinary (Instr 1 (Lit (IntLit 6)) (Lit (IntLit 3)) ) vm in
	            print $ runBinary (Instr 1 (Lit (IntLit 6)) (Lit (IntLit 3)) ) vm2 --add 6 and 3 and put to ACC(0)
 

--addictive...
main = do
	test2

