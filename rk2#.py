import re
t = '1NoahEmma2LiamOlivia3MasonSophia4JacobIsabella5WilliamAva6EthanMia7MichaelEmily'
result = re.sub(r'[;,\s]',' ', t)
print (result)
