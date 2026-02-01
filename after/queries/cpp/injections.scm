;; extends
;; Inject into C++ raw strings
(
 ((raw_string_content) @injection.content)
 (#match? @injection.content "^") ; Predicate to check the string's opening characters
 (#set! injection.language "regex"))

(
  ((raw_string_content) @injection.content)
  ; Predicate to check if the string is assigned to a variable named 'sql_query'
  (#match? @injection.content "SELECT.*") ; A simple check for the content to ensure it's likely SQL
  (#set! injection.language "sql")
)


