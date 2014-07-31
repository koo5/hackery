
import Data.List
import Data.Char
import Data.Int
--import Prelude.Int prelude is imported by default. its Data.Int
--We'll worry about modules when it's done
--data InstrDetails  = InstrDetails {instrName :: String, opcode :: Int} --That should be sufficient

type MemLoc        = Int
data Literal       = IntLit Int | CharLit Char --this seems about right, we just need to add a constructor from Int to IntLit, or not
		
data Operand       = Loc MemLoc | Lit Literal
type Opcode        = Int
data InstrType     = Instr Opcode Operand Operand
--data RegisterDef   = Register {name :: String, value :: [Int], id} --TODO?
type RegisterType  = Int -- wont memory be all of one type anyway?
type Registers     = [RegisterType] --mayb this isnt C? maybe--reading..this should work
data VmType        = Vm {instrPointer :: Int, regs :: Registers} deriving (Show)

--A few mathmatical functions that might come in handy some time

sqrt 0 = 0
sqrt n = n ** 0.5

--'Prototypes'

runBinary :: InstrType -> VmType -> VmType
--evalAsm   :: String -> Vm -> Vm
--Done.ok.i forgot, registers are just named memory locations? Yes.lets write some "tests", some example usage

updated list pos val =
	take pos list ++ val ++ drop (pos + 1) list

test0 (Instr a b c) z = print a
	

test1 = 
	let test = Vm 0 [3,4,5] in 
		print test

runBinary (Instr opcode op1 op2) vm = case opcode of
	0 -> vm
--runBinary (1 a b (ip, r)) = Vm ((ip + 1), updated r a a+b ) --am i haskelling yet? yes :)

test2 = 
	let myRegisters = [0]
	    vm          = Vm 0 myRegisters in
	    --print evalAsm "add x y" vm -- for later
	    --print $ runBinary Instr 0 00 0 vm --Right? will see.
	    print $ runBinary (Instr 1 (Loc 0) (Lit (IntLit 0))) vm
main = do
	test2

