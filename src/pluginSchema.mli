module type S = sig
  type message_t

  module AnyPointer : sig
    type t
  end

  module ElementSize : sig
    type t =
      | Empty
      | Bit
      | Byte
      | TwoBytes
      | FourBytes
      | EightBytes
      | Pointer
      | InlineComposite
      | Undefined_ of int
  end

  module Type : sig
    type t
    type array_t

    module Enum : sig
      type t
      type array_t

      val typeId_get : t -> Uint64.t
      val typeId_get_int_exn : t -> int
      val of_message : message_t -> t
    end

    module Interface : sig
      type t
      type array_t

      val typeId_get : t -> Uint64.t
      val typeId_get_int_exn : t -> int
      val of_message : message_t -> t
    end

    module List : sig
      type type_t = t
      type t
      type array_t

      val elementType_get : t -> type_t
      val of_message : message_t -> t
    end

    module Struct : sig
      type t
      type array_t

      val typeId_get : t -> Uint64.t
      val typeId_get_int_exn : t -> int
      val of_message : message_t -> t
    end

    type unnamed_union_t =
      | Void
      | Bool
      | Int8
      | Int16
      | Int32
      | Int64
      | Uint8
      | Uint16
      | Uint32
      | Uint64
      | Float32
      | Float64
      | Text
      | Data
      | List of List.t
      | Enum of Enum.t
      | Struct of Struct.t
      | Interface of Interface.t
      | Object
      | Undefined_ of int

    val unnamed_union_get : t -> unnamed_union_t
    val of_message : message_t -> t
  end

  module Value : sig
    type t
    type array_t

    type unnamed_union_t =
      | Void
      | Bool of bool
      | Int8 of int
      | Int16 of int
      | Int32 of int32
      | Int64 of int64
      | Uint8 of int
      | Uint16 of int
      | Uint32 of Uint32.t
      | Uint64 of Uint64.t
      | Float32 of float
      | Float64 of float
      | Text of string
      | Data of string
      | List of AnyPointer.t
      | Enum of int
      | Struct of AnyPointer.t
      | Interface
      | Object of AnyPointer.t
      | Undefined_ of int

    val unnamed_union_get : t -> unnamed_union_t
    val of_message : message_t -> t
  end

  module Annotation : sig
    type t
    type array_t

    val id_get : t -> Uint64.t
    val id_get_int_exn : t -> int
    val value_get : t -> Value.t
    val of_message : message_t -> t
  end

  module Method : sig
    type t
    type array_t

    val name_get : t -> string
    val codeOrder_get : t -> int
    val paramStructType_get : t -> Uint64.t
    val paramStructType_get_int_exn : t -> int
    val resultStructType_get : t -> Uint64.t
    val resultStructType_get_int_exn : t -> int
    val annotations_get : t -> (Annotation.t, array_t) Runtime.Array.t
    val of_message : message_t -> t
  end

  module Enumerant : sig
    type t
    type array_t

    val name_get : t -> string
    val codeOrder_get : t -> int
    val annotations_get : t -> (Annotation.t, array_t) Runtime.Array.t
    val of_message : message_t -> t
  end

  module Field : sig
    type t
    type array_t

    module Ordinal : sig
      type t
      type array_t

      type unnamed_union_t =
        | Implicit
        | Explicit of int
        | Undefined_ of int

      val unnamed_union_get : t -> unnamed_union_t
      val of_message : message_t -> t
    end

    module Group : sig
      type t
      type array_t

      val typeId_get : t -> Uint64.t
      val typeId_get_int_exn : t -> int
      val of_message : message_t -> t
    end

    module Slot : sig
      type t
      type array_t

      val offset_get : t -> Uint32.t
      val offset_get_int_exn : t -> int
      val type_get : t -> Type.t
      val defaultValue_get : t -> Value.t
      val hadExplicitDefault_get : t -> bool
      val of_message : message_t -> t
    end

    type unnamed_union_t =
      | Slot of Slot.t
      | Group of Group.t
      | Undefined_ of int

    val unnamed_union_get : t -> unnamed_union_t
    val name_get : t -> string
    val codeOrder_get : t -> int
    val annotations_get : t -> (Annotation.t, array_t) Runtime.Array.t
    val discriminantValue_get : t -> int
    val ordinal_get : t -> Ordinal.t
    val of_message : message_t -> t
  end

  module Node : sig
    type t
    type array_t

    module Struct : sig
      type t
      type array_t

      val dataWordCount_get : t -> int
      val pointerCount_get : t -> int
      val preferredListEncoding_get : t -> ElementSize.t
      val isGroup_get : t -> bool
      val discriminantCount_get : t -> int
      val discriminantOffset_get : t -> Uint32.t
      val discriminantOffset_get_int_exn : t -> int
      val fields_get : t -> (Field.t, array_t) Runtime.Array.t
      val of_message : message_t -> t
    end

    module Enum : sig
      type t
      type array_t

      val enumerants_get : t -> (Enumerant.t, array_t) Runtime.Array.t
      val of_message : message_t -> t
    end

    module Annotation : sig
      type t
      type array_t

      val type_get : t -> Type.t
      val targetsFile_get : t -> bool
      val targetsConst_get : t -> bool
      val targetsEnum_get : t -> bool
      val targetsEnumerant_get : t -> bool
      val targetsStruct_get : t -> bool
      val targetsField_get : t -> bool
      val targetsUnion_get : t -> bool
      val targetsGroup_get : t -> bool
      val targetsInterface_get : t -> bool
      val targetsMethod_get : t -> bool
      val targetsParam_get : t -> bool
      val targetsAnnotation_get : t -> bool
      val of_message : message_t -> t
    end

    module Const : sig
      type t
      type array_t

      val type_get : t -> Type.t
      val value_get : t -> Value.t
      val of_message : message_t -> t
    end

    module Interface : sig
      type t
      type array_t

      val methods_get : t -> (Method.t, array_t) Runtime.Array.t
      val extends_get : t -> (Uint64.t, array_t) Runtime.Array.t
      val of_message : message_t -> t
    end

    module NestedNode : sig
      type t
      type array_t

      val name_get : t -> string
      val id_get : t -> Uint64.t
      val id_get_int_exn : t -> int
      val of_message : message_t -> t
    end

    type unnamed_union_t =
      | File
      | Struct of Struct.t
      | Enum of Enum.t
      | Interface of Interface.t
      | Const of Const.t
      | Annotation of Annotation.t
      | Undefined_ of int

    val unnamed_union_get : t -> unnamed_union_t
    val id_get : t -> Uint64.t
    val id_get_int_exn : t -> int
    val displayName_get : t -> string
    val displayNamePrefixLength_get : t -> Uint32.t
    val displayNamePrefixLength_get_int_exn : t -> int
    val scopeId_get : t -> Uint64.t
    val scopeId_get_int_exn : t -> int
    val nestedNodes_get : t -> (NestedNode.t, array_t) Runtime.Array.t
    val annotations_get : t -> (Annotation.t, array_t) Runtime.Array.t
    val of_message : message_t -> t
  end

  module CodeGeneratorRequest : sig
    type t
    type array_t

    module RequestedFile : sig
      type t
      type array_t

      module Import : sig
        type t
        type array_t

        val id_get : t -> Uint64.t
        val id_get_int_exn : t -> int
        val name_get : t -> string
        val of_message : message_t -> t
      end

      val id_get : t -> Uint64.t
      val id_get_int_exn : t -> int
      val filename_get : t -> string
      val imports_get : t -> (Import.t, array_t) Runtime.Array.t
      val of_message : message_t -> t
    end

    val nodes_get : t -> (Node.t, array_t) Runtime.Array.t
    val requestedFiles_get : t -> (RequestedFile.t, array_t) Runtime.Array.t
    val of_message : message_t -> t
  end

end

module Make (MessageWrapper : Message.S) :
  (S with type message_t = Message.ro MessageWrapper.Message.t)
