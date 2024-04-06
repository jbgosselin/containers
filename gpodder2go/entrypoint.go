package main

import (
	"crypto/rand"
	"encoding/base64"
	"errors"
	"log"
	"os"
	"os/exec"
	"path/filepath"
	"strings"
	"syscall"
)

const (
	secretKeyPath        = "/data/VERIFIER_SECRET_KEY"
	secretKeyEnv         = "VERIFIER_SECRET_KEY"
	addrEnv              = "ADDR"
	defaultListeningAddr = "0.0.0.0:3005"
	dbPath               = "/data/g2g.db"
	binPath              = "/gpodder2go"
	binName              = "gpodder2go"
)

func main() {
	// Verifying the db file exists
	_, err := os.Stat(dbPath)
	if errors.Is(err, os.ErrNotExist) {
		// If file does not exists, run the init command
		log.Printf("database does not exists, running init\n")
		err := exec.Command(binPath, "init", "--database", dbPath).Run()
		if err != nil {
			log.Fatalf("failed to run database init: %v\n", err)
		}
	} else if err != nil {
		log.Printf("error while checking database file: %v\n", err)
	}

	// Check if secret is already present in env
	if os.Getenv(secretKeyEnv) == "" {
		log.Printf("no env %s found\n", secretKeyEnv)
		// Verify if the secret file exists
		_, err := os.Stat(secretKeyPath)
		if errors.Is(err, os.ErrNotExist) {
			// Generate new secret and save in file
			log.Printf("will generate new secret in file %s\n", secretKeyPath)
			rawKey := make([]byte, 30)
			_, err := rand.Read(rawKey)
			if err != nil {
				log.Fatalf("failed to generate random key: %v\n", err)
			}
			secretKey := base64.StdEncoding.EncodeToString(rawKey)
			err = os.WriteFile(secretKeyPath, []byte(secretKey), 0644)
			if err != nil {
				log.Fatalf("writing generated secret to file: %v\n", err)
			}
			err = os.Setenv(secretKeyEnv, secretKey)
			if err != nil {
				log.Fatalf("failed to set env %s: %v\n", secretKeyEnv, err)
			}
			log.Printf("successfully generated new secret in file %s\n", secretKeyPath)
		} else if err != nil {
			log.Fatalf("error while checking secret key file: %v\n", err)
		} else {
			// File exists, pulling secret from it
			secretKey, err := os.ReadFile(secretKeyPath)
			if err != nil {
				log.Fatalf("error while reading secret key file: %v\n", err)
			}
			err = os.Setenv(secretKeyEnv, string(secretKey))
			if err != nil {
				log.Fatalf("failed to set env %s: %v\n", secretKeyEnv, err)
			}
			log.Printf("retrieved env %s from file %s\n", secretKeyEnv, secretKeyPath)
		}
	}

	listeningAddr := defaultListeningAddr
	if v := os.Getenv(addrEnv); v != "" {
		listeningAddr = v
	}

	argv0 := binPath
	argv := []string{binName, "serve", "--database", dbPath, "--addr", listeningAddr}

	if len(os.Args) > 1 {
		if strings.HasPrefix(os.Args[1], "/") {
			argv0 = os.Args[1]
			baseName := filepath.Base(os.Args[1])
			argv = append([]string{baseName}, os.Args[2:]...)
		} else if os.Args[1] == binName {
			argv = os.Args[1:]
		} else {
			argv = append([]string{binName}, os.Args[1:]...)
		}
	}

	err = syscall.Exec(argv0, argv, os.Environ())
	if err != nil {
		log.Fatalf("failed to exec command %s %v : %v\n", argv0, argv, err)
	}
}
