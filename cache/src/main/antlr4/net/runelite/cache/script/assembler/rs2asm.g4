/*
 * Copyright (c) 2017, Adam <Adam@sigterm.info>
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright notice, this
 *    list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 *    this list of conditions and the following disclaimer in the documentation
 *    and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
 * ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */
grammar rs2asm;

prog: (attr NEWLINE)* (line NEWLINE)+ ;

attr: '.attr ' attr_idx ' ' attr_key ' ' attr_value ;
attr_idx: INT ;
attr_key: INT ;
attr_value: INT ;

line: instruction | label ;
instruction: instruction_name instruction_operand ;
label: 'LABEL' INT ':' ;

instruction_name: name_string | name_opcode ;
name_string: INSTRUCTION ;
name_opcode: INT ;

instruction_operand: operand_int | operand_qstring | operand_label | ;
operand_int: INT ;
operand_qstring: QSTRING ;
operand_label: 'LABEL' INT ;

NEWLINE: '\n'+ ;
INT: '-'? [0-9]+ ;
QSTRING: '"' (~('"' | '\\' | '\r' | '\n') | '\\' ('"' | '\\'))* '"' ;
INSTRUCTION: [a-z0-9_]+ ;

WS: (' ' | '\t')+ -> channel(HIDDEN) ;