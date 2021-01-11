from Crypto.Cipher import AES
from binascii import b2a_hex, a2b_hex

def aes_encrypt(key, origin_data):

    cryptor = AES.new(key, AES.MODE_ECB)
    return b2a_hex(cryptor.encrypt(origin_data))

def aes_decrypt(key, origin_data):

    cryptor = AES.new(key, AES.MODE_ECB)
    return b2a_hex(cryptor.decrypt(origin_data))




input_data = a2b_hex('5055e0ec75049cff0a14443f24c5effb')
key        = a2b_hex('ab7240f9c5e0bb5eee8e34b6bb84cfb0')


print(aes_encrypt(key, input_data))
print(len(aes_encrypt(key, input_data)))
