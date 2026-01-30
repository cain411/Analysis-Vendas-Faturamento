
# Instalação e Carregamento de Pacotes ------------------------------------
#install.packages("dplyr")
#install.packages("ggplot2")
#install.packages("readxl")


library(dplyr)
library(ggplot2)
library(readxl)

# Importação e Conhecimento de Dados --------------------------------------
vendas_df <- read_excel("Vendas.xlsx")


View(vendas_df)
head(vendas_df)
str(vendas_df)    #função str é igual a .info() do python
summary(vendas_df)  #função summary é igual a .describe() do python


# Manipulação dos Dados ---------------------------------------------------

  #faturamento total calculo: 
faturamento_max <- sum(vendas_df$Valor_Final)
print(faturamento_max)

  #faturamento por lojas (ID_Loja x Valor final) sem pipe:
#faturamento_loja <- group_by(vendas_df, ID_Loja)#função group_by agrupa colunas
#faturamento_loja <- summarise(faturamento_loja, faturamento_total = sum(Valor_Final)) #summarise faz contas estatisticas com as coisas do group_by

  #faturamento por lojas com pipe:
faturamento_loja2 <- vendas_df %>%  #o operador pipe pega tudo que está a sua esquerda e joga como primeiro argumento da função a sua direita
  group_by(ID_Loja) %>%   #lembrar de sempre quebrar a linha após o pipe
  summarise(faturamento_total = sum(Valor_Final))

  #faturamento por produtos:
faturamento_produto <- vendas_df %>% 
  group_by(ID_Loja, Produto) %>% 
  summarise(faturamento_total = sum(Valor_Final))



# Visualização dos Dados --------------------------------------------------

  #iguatemi campinas está com faturamento altíssimo;
  
  #vendas de bermuda lisa em campinas são altissimas, as outras nao vendem;
  
#gráfico faturamento loja:
ggplot(data = faturamento_loja, mapping = aes(x = ID_Loja, y = faturamento_total, fill = ID_Loja)) +
  geom_bar(stat = "identity") +
  theme_minimal() +
  labs(title = "Faturamento por Loja", subtitle = "Campinas é a loja com maior faturamento", x = NULL, y = "Faturamento") 
  
#gráfico faturamento produto:
ggplot(data = faturamento_produto, mapping = aes(x = ID_Loja, y = faturamento_total, fill = Produto)) +
  geom_col(position = "dodge") +#barra uma ao lado da outra
  theme_minimal() +
  labs(title = "Faturamento por Produto", subtitle = "Bermuda Lisa é o campeão de vendas", x = NULL, y = "Faturamento")

