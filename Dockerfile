# clean base image containing only comfyui, comfy-cli and comfyui-manager
FROM runpod/worker-comfyui:5.5.0-base
# install custom nodes into comfyui
RUN comfy node install --exit-on-fail city96/ComfyUI-GGUF
RUN comfy node install --exit-on-fail comfyui-custom-scripts@1.2.5
RUN comfy node install --exit-on-fail comfys3@1.0.1

RUN comfy model download --url https://huggingface.co/tarn59/pixel_art_style_lora_z_image_turbo/resolve/main/pixel_art_style_z_image_turbo.safetensors --relative-path models/loras --filename pixel_art_style_z_image_turbo.safetensors

RUN comfy model download --url https://huggingface.co/Comfy-Org/z_image_turbo/resolve/main/split_files/diffusion_models/z_image_turbo_bf16.safetensors --relative-path models/diffusion_models --filename z_image_turbo_bf16.safetensors

RUN comfy model download --url https://huggingface.co/Comfy-Org/z_image_turbo/resolve/main/split_files/vae/ae.safetensors --relative-path models/vae --filename ae.safetensors
RUN comfy model download --url https://huggingface.co/bartowski/Qwen_Qwen3-4B-GGUF/resolve/main/Qwen3-4B.Q5_K_M.gguf --relative-path models/text_encoders --filename Qwen3-4B.Q5_K_M.gguf