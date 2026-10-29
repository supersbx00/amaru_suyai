function scr_colision() {
if (creador == "player2" || creador == "enemy")
{
    // Con el escudo de Wanku, el ataque desaparece sin hacer daño
    if (!instance_exists(obj_escudo_tuto))
        obj_player_battle.barHealth -= danho;

    instance_destroy();
}

if (creador == "player1" || creador == "player2")
{
    obj_enemigo.barHealth -= danho;
    instance_destroy();
}
}
