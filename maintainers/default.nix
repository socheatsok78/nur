/*
  List of NUR maintainers.
  ```nix
   handle = {
     # Required
     name = "Your name";

     # Optional, but at least one of email, matrix or githubId must be given
     email = "address@example.org";
     matrix = "@user:example.org";
     github = "GithubUsername";
     githubId = your-github-id;

     keys = [{
       fingerprint = "AAAA BBBB CCCC DDDD EEEE  FFFF 0000 1111 2222 3333";
     }];
   };
   ```

   where

   - `handle` is the handle you are going to use in nixpkgs expressions,
   - `name` is a name that people would know and recognize you by,
   - `email` is your maintainer email address,
   - `matrix` is your Matrix user ID,
   - `github` is your GitHub handle (as it appears in the URL of your profile page, `https://github.com/<userhandle>`),
   - `githubId` is your GitHub user ID, which can be found at `https://api.github.com/users/<userhandle>`,
   - `keys` is a list of your PGP/GPG key fingerprints.

  See https://github.com/NixOS/nixpkgs/blob/nixos-unstable/maintainers/maintainer-list.nix for an example.
*/

{
  socheatsok78 = {
    name = "Socheat Sok";
    email = "socheatsok78@gmail.com";
    github = "socheatsok78";
    githubId = 4363857;
  };
}
