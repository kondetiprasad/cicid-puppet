class beaver::output::redis_out {
        create_resources('beaver::output::redis',hiera('redis_out'))     
}
