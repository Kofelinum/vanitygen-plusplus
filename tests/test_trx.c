#include <assert.h>
#include <openssl/ec.h>
#include <openssl/obj_mac.h>
#include <string.h>
#include "util.h"
#include "sha3.h"
#include "ticker.h"

int TRXFlag = 0;
int GRSFlag = 0;
char ticker[10];

static void test_trx_encode_decode(void)
{
    EC_KEY *key = EC_KEY_new_by_curve_name(NID_secp256k1);
    assert(key != NULL);
    assert(EC_KEY_generate_key(key) == 1);

    const EC_GROUP *group = EC_KEY_get0_group(key);
    const EC_POINT *pub = EC_KEY_get0_public_key(key);

    TRXFlag = 1;
    strcpy(ticker, "TRX");
    char addr[64];
    vg_encode_address(pub, group, 65, 0, addr);

    unsigned char bin[21];
    int res = vg_b58_decode_check(addr, bin, sizeof(bin));
    assert(res == 21);
    assert(bin[0] == 65);

    unsigned char pubbuf[65];
    unsigned char hash[32];
    EC_POINT_point2oct(group, pub, POINT_CONVERSION_UNCOMPRESSED,
                       pubbuf, sizeof(pubbuf), NULL);
    SHA3_256(hash, pubbuf + 1, 64);

    unsigned char expected[21];
    expected[0] = 65;
    memcpy(expected + 1, hash + 12, 20);
    assert(memcmp(bin, expected, 21) == 0);

    EC_KEY_free(key);
}

int main(void)
{
    test_trx_encode_decode();
    return 0;
}
