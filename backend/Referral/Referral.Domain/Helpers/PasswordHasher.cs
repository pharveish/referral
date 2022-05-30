using System;
using System.Linq;
using System.Security.Cryptography;

namespace Referral.Domain.Helpers
{
    public class PasswordHasher
    {
        
        private const int SALT_SIZE = 16;
        private const int KEY_SIZE = 32;
        private readonly int _iteration;

        public PasswordHasher(int iteration = 100)
        {
            _iteration = iteration;
        }

        public string Hash(string password)
        {
            using var algorithm = new Rfc2898DeriveBytes(password, SALT_SIZE, _iteration, HashAlgorithmName.SHA256);

            var key = Convert.ToBase64String(algorithm.GetBytes(KEY_SIZE));
            var salt = Convert.ToBase64String(algorithm.Salt);

            return $"{_iteration}.{salt}.{key}";
        }

        public bool Check(string hash, string password)
        {
            var parts = hash.Split('.', 3);

            if (parts.Length != 3)
            {
                throw new FormatException("Unexpected hash format.");
            }

            var iterations = Convert.ToInt32(parts[0]);
            var salt = Convert.FromBase64String(parts[1]);
            var key = Convert.FromBase64String(parts[2]);

            using var algorithm = new Rfc2898DeriveBytes(password, salt, iterations, HashAlgorithmName.SHA256);

            var keyToCheck = algorithm.GetBytes(KEY_SIZE);
            var verified = keyToCheck.SequenceEqual(key);

            return verified;
        }
    }
}