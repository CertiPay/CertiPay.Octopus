# CertiPay.Octopus.Redis

This package provides the ability to flush a given Redis database used as a cache during an Octopus deploy.

It utilizes StackExchange.Redis under the hood.

## Usage

Set RedisServer and RedisDatabaseId in the Octopus Deploy variables UI. Defaults to localhost and 0.