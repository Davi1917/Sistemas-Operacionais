#!/bin/bash

calcular_media() {
    local nota1=$1
    local nota2=$2
    echo $(( (nota1 + nota2) / 2 ))
}

realizar_frequencia() {
    alunos=("Aluno1" "Aluno2" "Aluno3")
    for aluno in "${alunos[@]}"; do
        read -p "$aluno está presente? (p/f): " presenca
        case $presenca in
            p)
                echo "$aluno: Presente"
                ;;
            f)
                echo "$aluno: Faltou"
                ;;
            *)
                echo "Opção inválida. Use 'p' para presente ou 'f' para faltou."
                ;;
        esac
    done
}

inserir_notas() {
    alunos=("Aluno1" "Aluno2" "Aluno3")
    for aluno in "${alunos[@]}"; do
        read -p "Insira a média final de $aluno: " media
        echo "$aluno: Média final inserida: $media"
    done
}

until [ ! -z "$cpf" ] || [ ! -z "$matricula" ]; do
    dialog --msgbox 'Bem-vindo(a) ao nosso sistema de atividades acadêmicas' 0 0

    dialog --yesno 'Você é um professor?' 0 0

    if [ $? -eq 0 ]; then
        echo "Ok, insira o seu CPF"
        read cpf
    else
        echo "Insira o seu número de matrícula"
        read matricula
    fi

    if [ -z "$cpf" ] && [ -z "$matricula" ]; then
        dialog --msgbox 'Login inválido. Por favor, insira CPF (professor) ou matrícula (aluno)' 0 0
    fi
done

if [ -n "$cpf" ]; then
    opcao=$(dialog --stdout --menu 'O que deseja fazer, professor?' 0 0 0 \
        1 'Realizar frequência' \
        2 'Inserir notas' \
        3 'Sair do sistema')

    case $opcao in
        1)
            echo "Opção 1: Realizar frequência"
            realizar_frequencia
            ;;
        2)
            echo "Opção 2: Inserir notas"
            inserir_notas
            ;;
        3)
            echo "Opção 3: Sair do sistema"
            ;;
        *)
            echo "Opção inválida"
            ;;
    esac
else
    echo "Insira suas notas:"
    read -p "Nota da primeira avaliação: " nota1
    read -p "Nota da segunda avaliação: " nota2

    media=$(calcular_media "$nota1" "$nota2")

    if [ $media -ge 6 ]; then
        echo "Parabéns! Você passou."
    else
        echo "Infelizmente, você não passou. Estude mais para a próxima."
    fi
fi
