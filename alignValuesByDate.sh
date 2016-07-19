#!/bin/sh
exec scala -savecompiled "$0" "$@"
!#

//--------------------------------------------------
// format
// 1998-01-23,DIA,52.5803,52.75,51.7747,52.2411
// 1998-01-26,DIA,52.4955,52.697,52.1987,52.4531
//--------------------------------------------------
//--------------------------------------------------
// Input arguments
//--------------------------------------------------
if (args.length != 4)
{
    println("wrong arguments. aborting")
    System.exit(1)
}
val filename = args(0)
val datecol = args(1).toInt
val symbolcol = args(2).toInt
val valuecol = args(3).toInt
//---------------------------------------------------


val srclines = scala.io.Source.fromFile(filename).getLines.toList
val lsDSP = srclines.map(line => {val tmp = line.split(",").toList; (tmp(datecol).replaceAll("-","").toInt, tmp(symbolcol), tmp(valuecol))})

var setDate = Set[Int]()
lsDSP.foreach(x => setDate += x._1)
val lsDate = setDate.toList.sorted

var setSym = Set[String]()
lsDSP.foreach(x => setSym += x._2)
val lsSym = setSym.toList.sorted

println((List("Date"):::lsSym).mkString(","))

val lsres = lsDate.map(d => (d, lsSym.map(s => lsDSP.filter(_._2 == s).filter(_._1 <= d).sorted.lastOption.getOrElse((0,0,0))._3).mkString(",")).toString)
println(lsres.mkString("\n"))
