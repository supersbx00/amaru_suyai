if (creador != other.creador)
{
    if (danho < other.danho)
        instance_destroy();
    else if (danho == other.danho)
        instance_destroy();
}
