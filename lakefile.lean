
import Lake
open Lake DSL

package «ReverseFFIWithMathlib» where
  -- add package configuration options here

lean_lib «ReverseFFIWithMathlib» where
  -- add library configuration options here

lean_exe Main where
  root := `Main

@[default_target]
lean_lib «reverseffiwithmathlib» where
  roots := #[`ReverseFFIWithMathlib]
  defaultFacets := #[`shared]
  moreLinkArgs :=
    #["-L.lake/packages/aesop/.lake/build/lib/", "-lAesop",
      "-L.lake/packages/Cli/.lake/build/lib/", "-lCli",
      "-L.lake/packages/importGraph/.lake/build/lib/", "-lImportGraph",
      "-L.lake/packages/mathlib/.lake/build/lib/", "-lMathlib",
      "-L.lake/packages/proofwidgets/.lake/build/lib/", "-lProofWidgets",
      "-L.lake/packages/Qq/.lake/build/lib/", "-lQq",
      "-L.lake/packages/batteries/.lake/build/lib/", "-lBatteries",
      "-L.lake/packages/LeanSearchClient/.lake/build/lib/", "-lLeanSearchClient",
      "-lLake", "-lLean"]

require mathlib from git "https://github.com/leanprover-community/mathlib4" @ "master"
