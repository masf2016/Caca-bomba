
largura_tela = love.graphics.getWidth()
altura_tela = love.graphics.getHeight()

quadrado_padrao = 50
condicao_bomba = true
condicao_jogo = true

math.randomseed(os.time())  -- auxilia para garantir uma melhor aleatoriedado dos numeros da math.random


function love.load ()

  bloco_terraIMG = love.graphics.newImage("Dirt-grass-50x50.png")
  bombaIMG =  love.graphics.newImage("Bomb-50x50.png")
  esmeraldaIMG = love.graphics.newImage("Esmerald-50x50.png")
  topazioIMG = love.graphics.newImage("Topazio-50x50.png")
  rubiIMG = love.graphics.newImage("Rubi-50x50.png")
  vazioIMG = love.graphics.newImage("Dirt-grass-hole-50x50.png")

  cursor = love.mouse.newCursor("Shovel-50x50.png",0,0)

  largura_terra = bloco_terraIMG:getWidth()

  mousePosX = nil
  mousePosY = nil
  pontos = 0
  contador = 0
  mensagem = ""

  quadrado = {posx = 0, posy = 200, alt = 49, larg = 49}
  quadrados = {}

  itens = {}

  for i=1,32 do
    -- body...
  end
  armazena_itens ()
  armazena_quadrado ()
end

function love.draw ()
  local cor1 = ""
  local cor2 = ""
      love.mouse.setCursor(cursor)
      infoFont = love.graphics.newFont(15)
      love.graphics.setFont(infoFont)

      love.graphics.setColor(255,255,0)
      love.graphics.printf(" ESTE É O JOGO DA BOMBA\n CAVE O CHÃO E RETIRE OS TESOUROS\n O JOGO TERMINA SE VOCÊ ATINGE A BOMBA ",0,10,400,'center')
      love.graphics.setColor(255,255,255)
      mensagem =  pontos.." Pontos"
      if condicao_jogo == false and contador ~= 63 then
        love.graphics.setColor(255,69,0)
        love.graphics.printf( " VOCÊ EXPLODIU A BOMBA! FIM DE JOGO PARA VOCE!\n SUA PONTUAÇÃO FOI: \n"..pontos.." pontos",0, 100,400,'center')
        love.graphics.setColor(255,255,255)
      end
      if contador == 63  and condicao_jogo == false then
        love.graphics.setColor(135,206,250)
        love.graphics.printf(" PARABÉNS!\n RETIROU TODOS OS TESOUROS SEM DETORNAR A BOMBA! \n SUA PONTUAÇÃO FOI: \n"..pontos.." pontos",0, 100,400,'center')
        love.graphics.setColor(255,255,255)
      end

  --    love.graphics.printf( mensagem,0, 100,400,'center')

        desenha_item ()
        desenha_quadrado ()
end


function love.update ()

end



function desenha_quadrado ()
  --[[
      Desenha o array dos blocos de terra em tela a partir da tabela quadrados
  ]]
      for i,v in ipairs(quadrados) do
           love.graphics.draw(bloco_terraIMG, v.x, v.y)
      end
end

function desenha_item ()
  --[[
      Desenha o array dos blocos de terra em tela a partir da tabela quadrados
  ]]
      imagem = ""
      for i,v in ipairs(itens) do
              if v.tipo == "" then
                imagem = vazioIMG
              elseif v.tipo == "esmeralda" then
                imagem = esmeraldaIMG
              elseif v.tipo == "topazio" then
                imagem = topazioIMG
              elseif v.tipo == "rubi" then
                imagem = rubiIMG
              elseif v.tipo == "bomba" then
                imagem = bombaIMG
              end
           love.graphics.draw(imagem, v.ix, v.iy)
      end
end

function armazena_quadrado ()
  --[[
      Armazenda em um array a posição dos blocos de terra em tela
  ]]
      for i=1,8 do
        for j=1,8 do
            table.insert (quadrados, {x = quadrado.posx, y = quadrado.posy})
            quadrado.posx = quadrado.posx + quadrado_padrao  -- acrescenta 50px a posição X do quadrado
        end
          quadrado.posx = 0   --seta para a posição inicial
          quadrado.posy = quadrado.posy + quadrado_padrao  -- acrescenta 50px a posição Y do quadrado
      end
          quadrado.posy = 200  --seta para a posição inicial

      for i,v in ipairs(quadrados) do
--            print(v.x, v.y)  -- para debugar
      end
end

function armazena_itens ()
  --[[
      Armazenda em um array a posição dos blocos de terra em tela
    ]]

      locali = math.random(8) -- gera um numero aleatorio para a posicao x da matriz para inserir a bomba
      localj = math.random(8) -- gera um numero aleatorio para a posicao y da matriz para inserir a bomba
      print(locali, localj)
      for i=1,8 do
        for j=1,8 do
            aleatorio = math.random(1, 10) --gera um numero de 1 a 10 para a seleção abaixo
            item = ""

                  if aleatorio >= 0 and aleatorio <= 5 and locali ~= i and localj ~= j then
                    item = "esmeralda"
                  elseif aleatorio > 5 and aleatorio <=8 and locali ~= i and localj ~= j then
                    item = "topazio"
                  elseif aleatorio > 8 and aleatorio <= 10 and locali ~= i and localj ~= j then
                    item = "rubi"
                  elseif aleatorio == 10 and condicao_bomba == true then
                    item = "bomba"
                    condicao_bomba = false
                  end

            table.insert (itens, {ix = quadrado.posx, iy = quadrado.posy,tipo = item, estado = true})
            quadrado.posx = quadrado.posx + quadrado_padrao  -- acrescenta 50px a posição X do quadrado
        end
          quadrado.posx = 0   --seta para a posição inicial
          quadrado.posy = quadrado.posy + quadrado_padrao  -- acrescenta 50px a posição Y do quadrado
      end
          quadrado.posy = 200  --seta para a posição inicial


      for i,j in ipairs(itens) do
          print(j.ix,j.iy,j.tipo,j.estado)  -- para debugar
      end
end


function love.mousepressed(mx, my, button, istouch)

      if button == 1 and condicao_jogo == true then
        for i,v in ipairs(quadrados) do
          if mx >= v.x and mx <= v.x + quadrado_padrao and my >= v.y and my <= v.y + quadrado_padrao then
        --      print("peguei", v.x, v.y, mx, my) -- para debugar
            table.remove(quadrados, i)
          end
        end

        for i,k in ipairs(itens) do

          if mx >= k.ix and mx <= k.ix + quadrado_padrao and my >= k.iy and my <= k.iy + quadrado_padrao then

              if k.tipo == "esmeralda" and k.estado == true then
                contador = contador + 1
                pontos = pontos + 12
                k.estado = false
              elseif k.tipo == "topazio" and k.estado == true then
                contador = contador + 1
                pontos = pontos + 35
                k.estado = false
              elseif k.tipo == "rubi" and k.estado == true then
                contador = contador + 1
                pontos = pontos + 62
                k.estado = false
              elseif k.tipo == "" and k.estado == true then
                contador = contador + 1
                k.estado = false
              elseif k.tipo == "bomba" and k.estado == true then
                condicao_jogo = false
              end

              if contador == 63 then
                condicao_jogo = false
              end

              print("peguei",contador, k.ix, k.iy, k.tipo, k.estado) --para debugar
          end
      end
    end
end
