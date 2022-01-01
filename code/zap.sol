//  Forge Auctions Contract REMOIVE PAYABLE FROM AUCTIONS CONTRACT SINCE WE ONLY USE 0xBitcoin
//   Auctions 8,192 tokens every 3 days and users are able to withdraw anytime after!

//   Proceeds of auctions go back into the miners pockets, by going directly to the Proof of Work Contract!

// 10,500,000 tokens are Auctioned off over 100 years in this contract! In the first era ~5,000,000 are auctioned and half every era after!

//   Distributes 8,192 tokens every 3 days for the first era(5 years) and halves every era after

// By using the burn0xBTCForMember function
//       0xBitcoin Token is taken from the user and used to recieve your share of the 8,192 tokens auctioned every 3 days which varies with Forge epoch speeds!  


pragma solidity ^0.8.0;

contract OwnableAndMods{
    address public owner;
    address [] public moderators;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    constructor() {
        owner = msg.sender;
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        require(msg.sender == owner, "Ownable: caller is not the owner");
        _;
    }
    modifier OnlyModerators() {
    bool isModerator = false;
    for(uint x=0; x< moderators.length; x++){
    	if(moderators[x] == msg.sender){
		isModerator = true;
		}
		}
        require(msg.sender == owner || isModerator, "Ownable: caller is not the owner/mod");
        _;
    }
}


library SafeMath {
    function add(uint256 x, uint256 y) internal pure returns (uint256) {
        uint256 z = x + y;
        require(z >= x, "Add overflow");
        return z;
    }

    function sub(uint256 x, uint256 y) internal pure returns (uint256) {
        require(x >= y, "Sub underflow");
        return x - y;
    }

    function mult(uint256 x, uint256 y) internal pure returns (uint256) {
        if (x == 0) {
            return 0;
        }

        uint256 z = x * y;
        require(z / x == y, "Mult overflow");
        return z;
    }

    function div(uint256 x, uint256 y) internal pure returns (uint256) {
        require(y != 0, "Div by zero");
        return x / y;
    }

    function divRound(uint256 x, uint256 y) internal pure returns (uint256) {
        require(y != 0, "Div by zero");
        uint256 r = x / y;
        if (x % y != 0) {
            r = r + 1;
        }

        return r;
    }
}

library ExtendedMath {


    //return the smaller of the two inputs (a or b)
    function limitLessThan(uint a, uint b) internal pure returns (uint c) {

        if(a > b) return b;

        return a;

    }
}
interface IERC20 {

    /**
     * @dev Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves `amount` tokens from the caller's account to `recipient`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address recipient, uint256 amount) external returns (bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(address owner, address spender) external view returns (uint256);

    /**
     * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * IMPORTANT: Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an {Approval} event.
     */
    function approve(address spender, uint256 amount) external returns (bool);

    /**
     * @dev Moves `amount` tokens from `sender` to `recipient` using the
     * allowance mechanism. `amount` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);

    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);
   
    
}

contract GasPump {
    bytes32 private stub;

    modifier requestGas(uint256 _factor) {
        if (tx.gasprice == 0 || gasleft() > block.gaslimit) {
            uint256 startgas = gasleft();
            _;
            uint256 delta = startgas - gasleft();
            uint256 target = (delta * _factor) / 100;
            startgas = gasleft();
            while (startgas - gasleft() < target) {
                // Burn gas
                stub = keccak256(abi.encodePacked(stub));
            }
        } else {
            _;
        }
    }
}

contract LiquidityPool{
    function addLiquidity(address, address, uint256, uint256, uint256, uint256 , address, uint256 ) public returns (bool) {}
    
    function getMiningReward() public view returns (uint) {}
    }
contract ForgeAuctions{
    function getMiningMinted() public view returns (uint) {}
    function FutureBurn0xBTCArrays(uint , uint[] memory , address, uint[] memory ) public payable returns (bool) {}
    function FutureBurn0xBTCEasier(uint, uint, uint, address , uint ) public payable returns (bool) {}
    function WholeEraBurn0xBTCForMember(address, uint256) public payable returns (bool){}
    function burn0xBTCForMember(address, uint256) public payable  {}
    }
contract ForgeStaking{
    function getMiningMinted() public view returns (uint) {}
    
    function getMiningReward() public view returns (uint) {}
    }

  contract ForgeZap is  GasPump, OwnableAndMods
{

    using SafeMath for uint;
    using ExtendedMath for uint;
    address public AddressZeroXBTC;
    address public AddressForgeToken;
    // ERC-20 Parameters
    uint256 public extraGas;
    bool runonce = false;
    uint256 oneEthUnit = 1000000000000000000; 
    uint256 one0xBTCUnit =         100000000;
    string public name;
    uint public decimals;

    // ERC-20 Mappings
    mapping(address => uint) private _balances;
    mapping(address => mapping(address => uint)) private _allowances;
    address public zXBitcoinAddress;
    address public ForgeAddress;
    address public Liquidity_PoolAddress;
    address public StakingAddress;
    address public AuctionAddress;

    // Public Parameters
     uint public timescalled;
    uint256 public amountZapped; uint public currentDay;
    uint public daysPerEra; uint public secondsPerDay;
    uint public nextDayTime;
    uint public totalBurnt; uint public totalEmitted;
    // Public Mappings
    
    ForgeAuctions Forge_Auction;
    ForgeStaking Forge_Staking;
    LiquidityPool LP;
    // Events
        event Zap(uint256 ZeroXBitcoinAmount, uint256 ForgeAmount);
        event Burn(uint256 totalburn, address burnedFor, uint TotalDaysBurned);
    event NewDay(uint era, uint day, uint time, uint previousDayTotal, uint previousDayMembers);
    event Burn(address indexed payer, address indexed member, uint era, uint day, uint units, uint dailyTotal);
    event BurnMultipleDays(address indexed payer, address indexed member, uint era, uint NumberOfDays, uint totalUnits);
    //event transferFrom2(address a, address _member, uint value);
    event Withdrawal(address indexed caller, address indexed member, uint era, uint day, uint value, uint vetherRemaining);
    //ProofofWorkStuff
    
    event MegaWithdrawal(address indexed caller, address indexed member, uint era, uint TotalDays, uint256 stricttotal);
    uint256 starttime = 0;
    uint256 public lastepoch = 0;
    uint256 public lastMinted = 0;
    uint256 public blocktime = 36 * 60; //36 min blocks in ProofOfWork
    //=====================================CREATION=========================================//

    //testing//

    // Constructor
    
    
    
    // ERC20 Transfer function
    // ERC20 Approve function


        function zSetUP1(address token, address _ZeroXBTCAddress) public onlyOwner {
        AddressForgeToken = token;
        lastMinted =  0;
        AddressZeroXBTC = _ZeroXBTCAddress;
        //ForgeMiningToken = ForgeMiningCT(token);
 //       lastMinted = ForgeMiningToken.getMiningMinted();
        starttime = block.timestamp;

    }

   function 

    function GetLPTokens(address tokenA, address tokenB, uint256 amountADesired, uint256 amountBDesired, uint256 amountAMin, uint256 amountBMin, address to, uint256 deadline) public payable returns (bool success)
    {
        LP.addLiquidity(tokenA, tokenB, amountADesired, amountBDesired, amountAMin, amountBMin, to, deadline);
        return true;
    }

    function WholeEraBurn0xBTCForMember(address member, uint256 _0xbtcAmountTotal) public payable returns (bool success)
    {
        Forge_Auction.WholeEraBurn0xBTCForMember(member, _0xbtcAmountTotal);
        return true;
    }

    function FutureBurn0xBTCEasier(uint _era, uint startingday, uint totalNumberrOfDays, address _member, uint _0xbtcAmountTotal) public payable returns (bool success)
    {
        Forge_Auction.FutureBurn0xBTCEasier(_era, startingday, totalNumberrOfDays, _member, _0xbtcAmountTotal);
    
        return true;
    }

    function FutureBurn0xBTCArrays(uint _era, uint[] memory fdays, address _member, uint[] memory _0xbtcAmount) public payable returns (bool success)
    {
       Forge_Auction.FutureBurn0xBTCArrays(_era, fdays, _member, _0xbtcAmount);
        return true;
    }

    function burn0xBTCForMember(address member, uint256 _0xbtcAmount) public payable returns (bool success)  {
        Forge_Auction.burn0xBTCForMember(member, _0xbtcAmount);
        return true;            
}
    
    
    
    
    function z_transferERC20TokenToMinerContract(address tokenAddress, uint tokens) public returns (bool success) {
        require((tokenAddress != address(this)) && tokenAddress != AddressForgeToken);
        return IERC20(tokenAddress).transfer(AddressForgeToken, IERC20(tokenAddress).balanceOf(address(this))); 

    }
}
