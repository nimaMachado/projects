

def visualiser(board): 

    chars = { -1: 'X',+1: 'O',0: '.' }
    str_line = '+-------------+' 
    print('\n' + str_line)
    for row in board:
        for cell in row:
            symbol = chars[cell]
            print(f': {symbol} :', end='')
        print('\n' + str_line)



def etatsVoisins(board) :
    indice = []
    i=0
    for c in board :
        if (c[0] == 0) : 
            indice.append([i,0])
        if (c[1] == 0) : 
            indice.append([i,1])
        if (c[2] == 0) : 
            indice.append([i,2])
        i=i+1 
    return indice

def choixValide(x,y,board) : 
    liste=[x,y]
    indice=etatsVoisins(board) 
    if liste in indice :
        return True 
    else :
        return False

def aGagne(board, joueur):
    win = [
        [board[0][0], board[0][1], board[0][2]], [board[1][0], board[1][1], board[1][2]], [board[2][0], board[2][1], board[2][2]], [board[0][0], board[1][0], board[2][0]], [board[0][1], board[1][1], board[2][1]], [board[0][2], board[1][2], board[2][2]], [board[0][0], board[1][1], board[2][2]], [board[2][0], board[1][1], board[0][2]],
    ]
    if [joueur, joueur, joueur] in win :
        return True 
    else:
        return False


def tourJoueurHumain(board): 
    OK=False
    while OK == False:
        x = int(input('Entrer la valeur de x ')) 
        y = int(input('Entrer la valeur de y ')) 
        if choixValide(x,y,board) :
            board[x][y]=-1
            OK=True 
        else :
            return(board)

def finDuJeu(board):
    if aGagne(board,1) or aGagne(board,-1) :
        return True
    else :
        return False


#retourne quel joueur gagne à la fin d'une eventuelle partie
#ou si il y a nulle tt simplement
def evaluate(state):
    if aGagne(state,-1) :
        return -100
    if aGagne(state,1) :
        return 100
    else :
        return 0


def minimax(state, depth, player):
    #1 for COMP and -1 for human
    if player == 1:
        best = [-1, -1, -100] 
    else:
        best = [-1, -1, 100]
    if depth == 0 or finDuJeu(state): 
        score = evaluate(state)
        return [-1, -1, score]
    for cell in etatsVoisins(state):
        x, y = cell[0], cell[1]
        state[x][y] = player
        score = minimax(state, depth - 1, -player) 
        state[x][y] = 0
        score[0], score[1] = x, y

        if player == 1:
            if score[2] > best[2]:
                best = score # max value
        else:
            if score[2] < best[2]:
                best = score #min value
    return best

def tourMachineMinimax(board) :
    depth = len(etatsVoisins(board)) 
    if depth == 0 or finDuJeu(board):
        return
    move = minimax(board, depth, 1)
    x, y = move[0], move[1] 
    board[x][y]=1


def jeuMorpionMinMax() :
    board=board = [ [0, 0, 0],[0, 0, 0],[0, 0, 0],] 
    visualiser(board)
    i=-1 
    gagne=False
    while gagne == False or i < 9 : 
        tourJoueurHumain(board)
        if (aGagne(board,-1)) :
            print("le joueur a gagne") 
            gagne=True
            break
        i=i+1
        #simple print pour voir l'avancement
        #print(i) 
        visualiser(board) 
        tourMachineMinimax(board)
        if (aGagne(board,1)) :
            print("la machine a gagne")
            gagne=True
            break 
        i=i+1
        visualiser(board) 
        if i>=9 :
            print("partie nulle")
            break
    print('Jeu Final')
    visualiser(board)

jeuMorpionMinMax() 






