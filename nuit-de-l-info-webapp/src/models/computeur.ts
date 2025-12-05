import type { Etat } from '@/models/state'
import type { OS } from '@/models/os'
export interface computeur {
  Type: 'Nouveau PC' | 'Pc Obselète'
  age: number
  os: OS
  etat: Etat
}
