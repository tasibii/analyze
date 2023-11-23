// SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.22;

import "boundry-deployment-kit/Base.s.sol";

interface INonfungiblePositionManager {
    function tokenOfOwnerByIndex(
        address owner,
        uint256 index
    ) external returns (uint256 tokenId);

    function balanceOf(address owner) external returns (uint256 balance);

    function positions(
        uint256 tokenId
    )
        external
        view
        returns (
            uint96 nonce,
            address operator,
            address token0,
            address token1,
            uint24 fee,
            int24 tickLower,
            int24 tickUpper,
            uint128 liquidity,
            uint256 feeGrowthInside0LastX128,
            uint256 feeGrowthInside1LastX128,
            uint128 tokensOwed0,
            uint128 tokensOwed1
        );
}

contract Analyze is BaseScript {
    address YU;
    address WBNB;
    INonfungiblePositionManager UNIV3POS;
    mapping(uint256 => mapping(address => uint256)) liquidityProvided;

    function setUp() public {
        vm.createSelectFork(vm.envString("RPC_URL_BSC"));
        UNIV3POS = INonfungiblePositionManager(
            0x7b8A01B39D58278b5DE7e48c8449c9f4F5170613
        );
        YU = 0x3e098C23DCFBbE0A3f468A6bEd1cf1a59DC1770D;
        WBNB = 0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c;
    }

    function analyzePoolFee3000() public {
        address[] memory addresses = _setUpAddresses();
        _combine(addresses);
        address addr;
        console2.log("*** Pool Fee 0.3% ***");
        for (uint256 i; i < addresses.length; ++i) {
            addr = addresses[i];
            console2.log(addr, " : ", liquidityProvided[3000][addr]);
        }
    }

    function analyzePoolFee10000() public {
        address[] memory addresses = _setUpAddresses();
        _combine(addresses);
        address addr;
        console2.log("*** Pool Fee 1% ***");
        for (uint256 i; i < addresses.length; ++i) {
            addr = addresses[i];
            console2.log(addr, " : ", liquidityProvided[10000][addr]);
        }
    }

    function _combine(address[] memory addresses) internal {
        address addr;
        uint256 tokenId;
        uint256 jLen;
        for (uint256 i; i < addresses.length; ++i) {
            addr = addresses[i];
            jLen = UNIV3POS.balanceOf(addr);
            for (uint256 j; j < jLen; ++j) {
                tokenId = UNIV3POS.tokenOfOwnerByIndex(addr, j);
                (
                    ,
                    ,
                    address token0,
                    address token1,
                    uint24 fee,
                    ,
                    ,
                    uint128 liquidity,
                    ,
                    ,
                    ,

                ) = UNIV3POS.positions(tokenId);

                if (token0 == YU && token1 == WBNB) {
                    liquidityProvided[uint256(fee)][addr] += uint256(liquidity);
                }
            }
        }
    }

    function _setUpAddresses()
        internal
        pure
        returns (address[] memory addresses)
    {
        addresses = new address[](70);
        addresses[0] = 0x91016F0c1297c6CCD1cF1b8fE370a7d04380A1E2;
        addresses[1] = 0xA8AE893Fa4877aA35905684c8314FCbE7BEFfDbe;
        addresses[2] = 0x8EA05047813444cE74A5E05a2BF672A04413FEB9;
        addresses[3] = 0xf49A401b8E023715d31cDd3A2De198aA40470F4A;
        addresses[4] = 0xCD7d2B9547B679868B3fe019696cFC5F51CF404f;
        addresses[5] = 0xEb5fFC5249B8040d91d9721A8cDECC7dBD8F5acc;
        addresses[6] = 0xD328bf221222373011c19a33F609fdc11bFaB079;
        addresses[7] = 0xE2D78733a7b39FE869D355c0600C8500Ff7817fE;
        addresses[8] = 0xd05E6943882394589F9976bd653394c8cf1a82EC;
        addresses[9] = 0x1dED19A2722856B202263D50F86c2476c99DCc2E;
        addresses[10] = 0x2F5fC51A5eC1c57F57DD0Abc28DA4E7FF33d54D5;
        addresses[11] = 0x1F6C598FcbB27a82640F780ec7e686b83D8A0aF0;
        addresses[12] = 0xe4496EF97E2f98Bc398Ba2b69715d3BEC7d89DF9;
        addresses[13] = 0xA8537D4a8e906B49d723E1e8D069BA602d696a7A;
        addresses[14] = 0x4503D29747e5B7E6222a3e47F98B3BF3f004b7b0;
        addresses[15] = 0x6607DBC6A2a590b2417B26eD271C999e11F51447;
        addresses[16] = 0x9Deab4AF72Bd22DB3Fe30EA6D9123Efb522CF0d7;
        addresses[17] = 0xD6c14d9D9e9A6ACcce1DfdD02bB07A450197020d;
        addresses[18] = 0xc5200378C611d1D705Ec8d06247530002C339DCD;
        addresses[19] = 0x8C0b2022384295FF7DdbD2b5F4522bbf39BCB292;
        addresses[20] = 0x049f6c28CdF347f6f6c91E761f8E17776d426627;
        addresses[21] = 0xAfa59a91192FAaCcCA7c66ED485eC957EE82d28a;
        addresses[22] = 0x124227d8D50463B43b9c448960C2c62212F78D20;
        addresses[23] = 0x63bc17A7a11af1aF96f916895C176DF864c69f40;
        addresses[24] = 0xD3b542eb6956447Fff8e6163165f993f0Ef017f3;
        addresses[25] = 0x922AdB7b94EBE5071D7e7a5919bc84cA8653B4E6;
        addresses[26] = 0xE1f58F1C5de65B421A7Ccba8791Dc82c389663Dd;
        addresses[27] = 0x483Ee4b33a722ec919D4ecf9860B778c72429107;
        addresses[28] = 0xBe6ADb815e31fd3BD2aA0190Fd1BE652f84CE7Ac;
        addresses[29] = 0xc4F083f72373963e9c67842db4E3ba42D32230bA;
        addresses[30] = 0xA3aaE6ebCD37D161BE6A3eD9D3201c3639Ce4Fd5;
        addresses[31] = 0x66255053686125aE96d7064A35876b2eA92Cb884;
        addresses[32] = 0xc42aD17605eC953d56343F3E7C14dfe641d7400c;
        addresses[33] = 0x59dDF3A8cDBc0d74e964160F88dac60E798Bb3Fe;
        addresses[34] = 0xd2D0ec2F367Dc2331D5e2BD115B1c85063e78F5E;
        addresses[35] = 0x6A712eBBd13647401Eba810Ec1E83995104D7D6C;
        addresses[36] = 0x9e57e62eB9F6A7A1f9ed16B5E949C87f862b1c8A;
        addresses[37] = 0x0e43B72e0eCaBDe1DFA7F5fB65ffBEb9Df3a3E77;
        addresses[38] = 0xc0FE969c302e26D82577b88cCd8B92dE7E79b8f4;
        addresses[39] = 0xf5b1B0eAe0296D9e34d3f6746d3744477f85C13F;
        addresses[40] = 0xdb5079FC47bFA071f1C48e33c431c3bD8752d206;
        addresses[41] = 0xa67096A541da77d54AD00F7756Dd5A4b23A2eF67;
        addresses[42] = 0x54c7D9cd9C1F0C9b0063e258F512f3606df69961;
        addresses[43] = 0xEbc405f0047be78DF6484cc21bAb71A99C160a50;
        addresses[44] = 0x896391359128E85f055885A04224a7225C5346Ad;
        addresses[45] = 0xA08B8af089341FD847d96adABc2DEd1D737Bc38A;
        addresses[46] = 0x8C982BDaB15c99702A81fF2f2acb63377447a4cd;
        addresses[47] = 0xB55e6b687013dE59B2C2180eB5B8E5560d28497c;
        addresses[48] = 0x1c98748eadF7072B40d69C5A6f5e685199F9d97A;
        addresses[49] = 0xd8dda9845aE645aCd9B6820498B56A488a14fa93;
        addresses[50] = 0x8d88051860f21831688ba9F0dAD61785434e0279;
        addresses[51] = 0xB33E2d21236930Cc32478A870EE4b856C8333407;
        addresses[52] = 0xb34326Be0Fb9e76CD445FEf21cD20634fEA8a725;
        addresses[53] = 0x43ee87D8C5DaA55E813A679A8808Dc9ECa25e52f;
        addresses[54] = 0x70d61ec49893605c6beaB56F0199F66Cc93Ed89a;
        addresses[55] = 0x6283902Eec082B78714946c01F6871912606b089;
        addresses[56] = 0xC04404c31c5a68599ABA0E2Afe097437e4749662;
        addresses[57] = 0xBc8695CD596c542D8c0859d000818b194F1BC940;
        addresses[58] = 0xEf1c2e4B55CaC19Ba26d09AD7F2595f147a04072;
        addresses[59] = 0xAceD1A7469153d003A6a0b00A6B2d135BB5f5c81;
        addresses[60] = 0xbeB3AdfA03a5a85C246359A86aF96Cbf1d0137C0;
        addresses[61] = 0x8b6483e8F3bD0297894C94974191bB3ffF31768D;
        addresses[62] = 0xFC17CAcFB9F9C715847029F8223069d5D12dEC66;
        addresses[63] = 0x404B0D9ceB1049Fe28C7CCE285b55672Fc87380d;
        addresses[64] = 0x71573E3540DFE08e2E813fEC752C27cBbf8A0Fe9;
        addresses[65] = 0x54B5fE8b38cd25BaEEC2E3f09782cBB98Ce13BC7;
        addresses[66] = 0x90881B70cAe3CE9E9E0d70161B6091408d125779;
        addresses[67] = 0xee0F91b31c883f98C6BF73d3DB27eca2be807E43;
        addresses[68] = 0x97bA8aD1264cB98E8240b84bC05E7077b3bC1A1E;
        addresses[69] = 0xA9a015b4be05eaAAa74771d30B9E01b2749848AE;
    }
}
