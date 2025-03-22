#!/bin/bash


clear
echo -e "\e[35m"
cat << 'EOF'
__| |____________________________________________________________________| |__
__   ____________________________________________________________________   __
  | |                                                                    | |
  | |  _________      .__    ________                    .__    ____  ___| |
  | | /   _____/ ____ |  |  /  _____/___________  ______ |  |__ \   \/  /| |
  | | \_____  \ /  _ \|  | /   \  __\_  __ \__  \ \____ \|  |  \ \     / | |
  | | /        (  <_> )  |_\    \_\  \  | \// __ \|  |_> >   Y  \/     \ | |
  | |/_______  /\____/|____/\______  /__|  (____  /   __/|___|  /___/\  \| |
  | |        \/                    \/           \/|__|        \/      \_/| |
__| |____________________________________________________________________| |__
__   ____________________________________________________________________   __
  | |                                                                    | |
EOF
echo -e "\e[36m\n    Generador de gráficos para contratos Solidity ᓚ₍ ^. ̫ .^₎"
echo -e "    Derechos reservados a HackSyndicate S.A.S.\e[0m\n"

echo -e "\e[34mEste script genera gráficos de dependencias, herencia, llamadas y flujo de control para contratos Solidity."
echo -e "Elige el tipo de formato de salida y presiona Enter:\e[0m"

echo -e


echo -e "\e[36mOpciones disponibles:\e[0m"
echo -e
options=("png" "svg" "pdf" "jpg")
select format in "${options[@]}"; do
    if [[ " ${options[@]} " =~ " ${format} " ]]; then
        break
    else
        echo -e "\e[31mOpción no válida. Intenta de nuevo.\e[0m"
    fi
done

echo -e

echo -e "\e[35mFormato seleccionado: $format\e[0m"

echo -e


mkdir -p graphs


animate_eth() {
    local symbols=("Ξ    " "  Ξ  " "    Ξ" "  Ξ  ")
    local i=0
    tput civis  

    while true; do
        echo -ne "\r ➤ Generando gráficos, espere un momento... ${symbols[i]}"
        sleep 0.3
        i=$(( (i + 1) % 4 ))  # Ciclo entre los símbolos
    done
}


animate_eth &
anim_pid=$!

# Generar grafo de dependencias
surya graph src/*.sol script/*.sol | dot -T$format -o graphs/dependencies.$format >/dev/null 2>&1

# Generar grafo de herencia
surya inheritance src/*.sol script/*.sol | dot -T$format -o graphs/inheritance.$format >/dev/null 2>&1

# Generar grafo de llamadas (Call Graph)
slither src/*.sol script/*.sol --print call-graph > graphs/callgraph.dot 2>/dev/null
if [[ -s graphs/callgraph.dot ]]; then
    dot -T$format graphs/callgraph.dot -o graphs/callgraph.$format >/dev/null 2>&1
fi
rm -f graphs/callgraph.dot 


for file in src/*.sol script/*.sol; do
    filename=$(basename "$file" .sol)
    slither "$file" --print cfg > "graphs/${filename}_cfg.dot" 2>/dev/null
    if [[ -s "graphs/${filename}_cfg.dot" ]]; then
        dot -T$format "graphs/${filename}_cfg.dot" -o "graphs/${filename}_cfg.$format" >/dev/null 2>&1
    fi
    rm -f "graphs/${filename}_cfg.dot"  
done


find src/ script/ -name "*.dot" -type f -delete


kill "$anim_pid" 2>/dev/null
wait "$anim_pid" 2>/dev/null
tput cnorm  

echo -e "\n ➤ Grafos generados en graphs/ con formato .$format "
