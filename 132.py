code = '<p> Bold Stuff <стр> textextext   gogogo </стр> <b>  (assf)lololo </b> </p>  <k> xoxooxxoxoxo</k>'
result = ''

st = 0

def automat(code, tag):
    i = 0
    text = ''
    while i < len(code):
        if st == 0:
            if i == '<' and st == 0:
                st = 1
            else:
                continue
        elif st == 1:
            count = 0
            for j in tag:
                if j == code[i]:
                    i += 1
                    count += 1
                else:
                    break
            if count == len(tag):
                st = 2
                i += 1
        else:
            while (code[i-1] != '<' and code[i] != '/' and st == 2):
                text += code[i]
                i += 1
            st = 3 
        
        if st == 3:
            count = 0
            for j in tag:
                if j == code[i]:
                    i += 1
                    count += 1
                else:
                    break
            if count == len(tag):
                st = 4
                i += 1
            else:
                st = 2

            if st == 4:
                st = 0
                
        if st == 1:
            if i == '<' and st == 0:
                st = 2
            else:
                continue
        else:
            if i ==  and st == 1:
                st = 1
            else:
                continue
