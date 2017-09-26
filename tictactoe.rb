def displayBoard(board) 
  puts "#{board[0]}  | #{board[1]} |  #{board[2]}"
  puts "------------"
  puts "#{board[3]}  | #{board[4]} |  #{board[5]}"
  puts "------------"
  puts "#{board[6]}  | #{board[7]} |  #{board[8]}"
end
def number_or_nil(string)
  num = string.to_i
  num if num.to_s == string
end
def maxNum(num1, num2)
  if num1 >= num2
    return num1
  else
    return num2
  end
end
def isThreeHaveSameMark(str1,str2,str3,mark)
  return (str1 == str2 && str1 == str3 && str1 == mark)
   
end
def getMyMark(isUser, isFirst)
  if (isUser && isFirst) || (!isUser && !isFirst)
    return "O"
  else 
    return "X"
  end
end
def checkIsUserFirst()
  puts "Enter \"0\" to become first！"
  isFirstString = gets
  isFirst = isFirstString.chomp() == "0" ? TRUE : FALSE
  usrMark = getMyMark(true,isFirst)
  computerMark = getMyMark(false,isFirst)
  puts "User Mark is #{usrMark}, and Computer Mark is #{computerMark}"
  return isFirst
end
def putChess(index, myboard, isUser, isFirst)
  #puts "putChess"
  #puts index
  selectNum = number_or_nil(index)
  if selectNum != nil && myboard[selectNum] == " " 
    myboard[selectNum] =  getMyMark(isUser, isFirst)
    return TRUE
  end
    return FALSE
end
def setComputerPriorityPutArray(myboard,priority, isFirst)
  userMark = getMyMark(TRUE,isFirst)
  computerMark = getMyMark(FALSE,isFirst)
  myMark = getMyMark(FALSE,isFirst)
  lineArray = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
  for i in 0..8
    priority[i] = 0
    if myboard[i] == " "
      for line in lineArray
        if line.include? i
          userMarkCount = 0
          computerMarkCount = 0
          line.each{|x|
            if myboard[x] == userMark 
              userMarkCount += 1
            elsif myboard[x] == computerMark
              computerMarkCount += 1
            end
          }
          if computerMarkCount == 2
            priority[i] = maxNum(priority[i],10)
          elsif userMarkCount == 2
            priority[i] = maxNum(priority[i],9)
          elsif computerMarkCount == 1
            priority[i] = maxNum(priority[i],8)
          else
            priority[i] = maxNum(priority[i],rand(7))
          end
        end
      end
      puts priority[i]
    end
  end
end
def computerSelectIndex(myboard, isFirst)
  priority = Array.new(9, 0)
  maxIndex = -1
  maxNum = 0
  setComputerPriorityPutArray(myboard,priority,isFirst)
  for i in 0..8
    if priority[i] > maxNum
      maxIndex = i
      maxNum = priority[i]
    end
  end
  return maxIndex
end
def checkWhoIsWin(myboard,isFirst)
  userMark = getMyMark(TRUE,isFirst)
  computerMark = getMyMark(FALSE,isFirst)
  lineArray = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
  for line in lineArray
    #User win return 1, Computer win return 2
    if isThreeHaveSameMark(myboard[line[0]],myboard[line[1]],myboard[line[2]],userMark)
      puts "User is Win"
      return 1
    elsif isThreeHaveSameMark(myboard[line[0]],myboard[line[1]],myboard[line[2]],computerMark)
      puts "Computer is Win"
      return 2
    end
  end
  #no one win return 0
  return 0
end


def gameStart()
  puts "Welcome to Tic Tac Toe!"
  myboard = Array.new(9, " ")
  displayBoard(myboard)
  turnIndex = 0
  isUserTurn = true
  
  isFirst = checkIsUserFirst()
  isUserTurn = isFirst
  for turnIndex in 0..8
    puts "Turn  #{turnIndex}: "
    while TRUE
      puts isUserTurn ? "User's Turn!! " : "Computer's Turn!! "
      if isUserTurn
        puts "Pleasse select a empty block"
        index = gets
        isCanPut = putChess(index.chomp(),myboard,isUserTurn,isFirst)
        if isCanPut
          displayBoard(myboard)
          break
        else 
          puts "Select Error "
        end
      else
        computerPut = computerSelectIndex(myboard,isFirst)
        putChess(computerPut.to_s,myboard,isUserTurn,isFirst)
        displayBoard(myboard)
        break
      end
      
    end 
    isUserTurn = !isUserTurn
    checkResult = checkWhoIsWin(myboard,isFirst)
    if checkResult != 0
      break
    end
  end
  puts "Game  Over"
end

gameStart()