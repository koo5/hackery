--ok, anything that isnt clear? not really. If a problem comes up we'll just go to #haskell, or, as i call it, hashkell:)
--so it works now? we just need to add more Instr's? well i dunno if we wanna add an...what is it even... for every instructi
--on, or --Oooh, we need the flags; they are set based off of the prev. instruction's result; if we 'cmp' 2 numbers
-- and they're not equal, we set the NE flag. did you say the VM should be realistic as in registerless? could the flags be 
--just more memory locations? sure -- lets do the naming somehow -- MemLoc....mmm... maybe we could make a malloc function, only 
--problem is, since haskell functions can't have side-effects, that'd be really hard. nothing hard about it #maybe it's doable:)
import Data.List
import Data.Char
import Data.Int

--We'll worry about modules when it's done
--data InstrDetails  = InstrDetails {instrName :: String, opcode :: Int} --That should be sufficient

rACC = 0--well, this could work...  What other registers besides ACC and a general purpose one will we need?dunno, your expertise:)
rGPA = 1 -- General purpose register 'a'
rGPB = 10 -- take a fuckin guess
rGPC =  100 -- original
rSPR = 1000 -- stack pointer


type MemLoc        = Int
data Literal       = IntLit Int | CharLit Char deriving (Eq)
		--back in a bit k
data Operand       = Loc MemLoc | Lit Literal deriving (Eq)-- An operand (or argument) of an assembly instruction 
type Opcode        = Int -- The opcode of an instruction
data InstrType     = Instr Opcode Operand Operand | Nop deriving (Eq) --ahh this is fine, just need it over there too
--data RegisterDef   = Register {name :: String, value :: [Int], id} --TODO?
type RegisterType  = Int -- wont memory be all of one type anyway? -- RegisterType; don't change
type Registers     = [RegisterType] -- Register contents
data VmType        = Vm {instrPointer :: Int, regs :: Registers} deriving (Show) -- Virtual machine instance description

intInstr opcode o1 o2 = 
	Instr opcode  (Lit(IntLit o1)) (Lit(IntLit o2))

someMem = replicate 1001 0
newVm = Vm 0 someMem

runBinary :: InstrType -> VmType -> VmType
evalAsm   :: String -> VmType -> VmType

evalAsm asmText vm = let
	--since when is asm a keyword in haskell?:D
	lns = lines asmText -- Tharnk you haskell stdlib --this is nice. --that was stupid--what happened?--i spaced out for a bit
	instrs = map parseStrToInstruction lns
	in
		evalInstructions instrs vm

evalInstructions :: [InstrType] -> VmType -> VmType

evalInstructions [] vm = vm

evalInstructions (i:[]) vm =
	runBinary i vm

evalInstructions (i:ix) vm =
	evalInstructions ix $ runBinary i vm

updated list pos val =
	take pos list ++ [val] ++ drop (pos + 1) list

---test0 (Instr a b c) z = print a

test1 =
	let test = Vm 0 [3,4,5] in
		print test

intval :: Operand -> Int

locval (Loc ( val)) = val

intval (Lit (IntLit val)) = val
subs = []
makeSub name endLoc = subs ++ (name, endLoc)

regFromInt :: Int -> RegisterType
regFromInt x = x

runBinary (Instr opcode op1 op2) (Vm ip regs) = case opcode of
	0 -> Vm (ip + 1) regs
	1 -> Vm (ip + 1)
		(updated regs 0 (regFromInt ((intval op1)+(intval op2))))

parseStrToInstruction :: String -> InstrType 

parseStrToInstruction s = do
	let x = words s
	    i = x !! 0
	    o1raw = x !! 1
	    o2raw = x !! 2
	    o1 = read o1raw :: Int in --clever huh?
		case i of
			"add" -> Instr 1 (Lit(IntLit o1)) (Lit(IntLit 3))
			"nop" -> Nop
			"g"
	--i = x
	--y = x !! 0:x !! 1:x !! 2 --without a simple slicing notation, this is the best i got. 3.
	--z = Instr y !! 0 y !! 1 y !! 2


testParse =
	parseStrToInstruction "add 3 3" == intInstr 1 3 3

--readAndExecuteOperationFromStr :: String -> VmType -> VmType

--readAndExectueOperationFromStr str vm = do
--	runBinary parseStrToInstruction vm

test2 = do
	print testParse
	let myRegisters = [0]
	    vm          = Vm 0 myRegisters in do --Should work...
	    --print evalAsm "add x y" vm -- for later
	    --print $ runBinary Instr 0 00 0 vm --Right? will see.
            print $ runBinary (Instr 0 (Loc 0) (Lit (IntLit 0))) vm
	    let vm2 = runBinary (Instr 1 (Lit (IntLit 6)) (Lit (IntLit 3)) ) vm in
	            print $ runBinary (Instr 1 (Lit (IntLit 6)) (Lit (IntLit 3)) ) vm2 --add 6 and 3 and put to ACC(0)
 


--The archaic way
test4 = evalAsm "sub \"mysub\"\
	\psh \"Hey\"\
	\cal \"print\"\
	\end\
	\jmp \"mylabel\"" newVm

--There. crude.

main = do
	test2
	print test4

