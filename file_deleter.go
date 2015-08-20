package main

import "os"
import "fmt"
import "time"
import "io/ioutil"
import "log"

var cutoff = 72 * time.Hour

func main()  {
    stash := "/path/to/dir"
    os.Chdir(stash)
    fileInfo, err := ioutil.ReadDir(stash)
    if err != nil {
      log.Fatal(err.Error())
    }
    now := time.Now()
    for _, info := range fileInfo {
      if diff := now.Sub(info.ModTime()); diff > cutoff {
	fmt.Printf("Deleting %s\n", info.Name())
        os.Remove(info.Name())
      }
    }
}
