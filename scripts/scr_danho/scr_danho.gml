// Daño de batalla: todo golpe que resta vida (de Amaru, Suyai o los enemigos) pasa por aquí.
// El valor de las cartas (quién gana el duelo) no cambia: solo la vida que se resta.
#macro BATALLA_DANHO_MULT 1.5

function scr_danho(valor) {
return ceil(valor * BATALLA_DANHO_MULT);
}
