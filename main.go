// Copyright 2015 Google Inc. All Rights Reserved.
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//     http://www.apache.org/licenses/LICENSE-2.0
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

package main

import (
	"fmt"
	"io/ioutil"
	"log"
	"os"
	"os/exec"
	"strings"

	"github.com/drone/drone-plugin-go/plugin"
)

type bash struct {
	Cmd    string
	Env    []string
	Script []string
}

const (
	defaultCmd = "/bin/bash"
	scriptName = "/tmp/script.sh"
)

var (
	workspace plugin.Workspace
	vargs     bash
)

func main() {
	log.SetFlags(0)
	plugin.Param("workspace", &workspace)
	plugin.Param("vargs", &vargs)
	plugin.MustParse()

	script := strings.Join(vargs.Script, "\n")
	if err := ioutil.WriteFile(scriptName, []byte(script), 0644); err != nil {
		log.Fatalf("WriteFile(%q): %v", script, err)
	}

	c := vargs.Cmd
	if c == "" {
		c = defaultCmd
	}
	cmd := exec.Command(c, scriptName)
	cmd.Dir = workspace.Path
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr
	cmd.Env = append(os.Environ(), vargs.Env...)

	fmt.Println("$", c, scriptName)
	if err := cmd.Run(); err != nil {
		log.Fatal(err)
	}
}
