# Encryption

RDS storage/snapshots and central log storage use AWS KMS customer-managed keys.

This addresses loss/theft of stored data and offline snapshot access. It does not protect plaintext while an authorised process is actively using the data.
