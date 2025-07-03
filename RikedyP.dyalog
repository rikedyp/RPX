:Namespace RikedyP ⍝ v0.2
⍝ Custom user commands

    ⎕IO←1 ⋄ ⎕ML←1

    ∇ r←List
      r←,⎕NS ⍬
    ⍝ Name, group, short description and parsing rules
      r.Name←⊆'LS'
      r.Group←⊆'RikedyP'
      r[1].Desc←'List directory contents'
      r.Parse←⊆'' ⍝ ENTER NUMBER OF ARGS AND OPTIONALLY -modifiers HERE (for details, see https://docs.dyalog.com/20.0/User%20Commands%20User%20Guide.pdf#page=18 )
    ∇

    ∇ r←Run(cmd input)
      :Select cmd
      :Case 'LS'
          r←LS input
      :EndSelect
    ∇

    ∇ r←level Help cmd
      :Select cmd
      :Case 'LS'
          r←'List contents of directory. Default is current directory, else user may provide a single argument of a relative or absolute folder path.'
      :EndSelect
    ∇

      LS←{
          0∊⍴⍵:∇⊃1 ⎕NPARTS''   ⍝ Default to current directory
          1≠1 ⎕NINFO ⍵:'Argument provided does not specify a directory.'
          dir←PlatformPath⊃1 ⎕NPARTS NormalPath ⍵
          r←⊂'Listing contents of ',dir
          (c t)←0 1(⎕NINFO ⎕OPT 1)dir,'*'
          c←PlatformPath¨c
          type←'dir' 'file' 'other'[t]
          ⍕⍪r,⊂type,⍪c
      }

      NormalPath←{
     ⍝ Remove double quotes; ensure trailing slash; normalise slashes by OS
          path,'/'/⍨~∨/'/\'∊⊃⌽path←⍵~'"'
      }

      PlatformPath←{
     ⍝ Normalise slashes in directory paths depending on operating system
     ⍝ Microsoft Windows: backslash     \
     ⍝             other: forward slash /
          windows←'W'=⊃⊃'.'⎕WG'APLVersion'
          windows:'\'@('/'∘=)⍵
          '/'@('\'∘=)⍵
      }

:EndNamespace
