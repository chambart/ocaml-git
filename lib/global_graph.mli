(*
 * Copyright (c) 2013-2014 Thomas Gazagnaire <thomas@gazagnaire.org>
 *
 * Permission to use, copy, modify, and distribute this software for any
 * purpose with or without fee is hereby granted, provided that the above
 * copyright notice and this permission notice appear in all copies.
 *
 * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 *)

(** Functions to manipulate the graph of Git objects. *)

module K: Graph.Sig.I with type V.t = SHA.t
(** The graph of Git keys. *)

module Make (S: Store.S): sig

  val of_keys: S.t -> K.t Lwt.t
  (** Return the graph of keys of the given Git store. *)

  val closure: S.t -> min:SHA.Set.t -> SHA.Set.t -> K.t Lwt.t
  (** Return a consistent cut of the graph of keys, where no elements
      are lesser than the ones in [min] and none are bigger than the
      ones in [max]. *)

  val pack: S.t -> min:SHA.Set.t -> SHA.Set.t -> Pack.t Lwt.t
  (** Return a packed (closed) collection of objects. *)

  val to_dot: S.t -> Buffer.t -> unit Lwt.t
  (** [to_dot g buffer] fille [buffer] with the `.dot` representation
      of the Git graph. *)

end
