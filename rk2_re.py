import re

code_to_search = '<p> Bold Stuff <стр> textextext   gogogo </стр> <b>  (assf)lololo </b> </p>  <k> <стр> textextext   gogogo </стр>  xoxooxxoxoxo</k>'
result = ''

pattern = re.compile(r'<p>([^\"]*)<\/p>')
matches = pattern.findall(code_to_search)
print('Параграф:', matches[0])
try:
        
    pattern = re.compile(r'<стр>([^\"]*)<\/стр>')
    gstr = pattern.findall(matches[0])
    print('Стр', gstr[0])
except:
    print('стр - пусто')
try:
    pattern = re.compile(r'<b>([^\"]*)<\/b>')
    gb = pattern.findall(matches[0])
    print('B', gb[0])
except:
    print('В - пусто')
