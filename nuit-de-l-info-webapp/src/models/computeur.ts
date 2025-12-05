import {Etat} from "@/models/state";
import {OS} from "@/models/os";
export interface computeur {
    Type: "Nouveau PC" | "Pc Obselète"
    age : number
    os : OS
    etat : Etat
}